/*
 * SquareRootCop.c: test of the square root processor
 *
 * Authors:
 * Paulo Vasconcelos
 * Pedro Teixeira
 * Arnaldo Oliveira
 *
 * Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
 * Copyrihgt (C) 2020 Paulo Vasconcelos, Pedro Teixeira
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "platform.h"
#include "xparameters.h"
#include "xaxidma.h"
#include "xtmrctr_l.h"
#include "xil_printf.h"

/****************************** Definitions **********************************/

typedef int bool;

#define min(a, b)		((a < b) ? a : b)

#define N				4095

#define DMA_DEVICE_ID	XPAR_AXIDMA_0_DEVICE_ID

#define SEED_VALUE		243248

/*********************** DMA Configuration Function **************************/

int DMAConfig(u16 dmaDeviceId, XAxiDma* pDMAInstDefs)
{
	XAxiDma_Config* pDMAConfig;
	int status;

	// Initialize the XAxiDma device
	pDMAConfig = XAxiDma_LookupConfig(dmaDeviceId);
	if (!pDMAConfig)
	{
		xil_printf("No DMA configuration found for %d.\r\n", dmaDeviceId);
		return XST_FAILURE;
	}

	status = XAxiDma_CfgInitialize(pDMAInstDefs, pDMAConfig);
	if (status != XST_SUCCESS)
	{
		xil_printf("DMA Initialization failed %d.\r\n", status);
		return XST_FAILURE;
	}

	if (XAxiDma_HasSg(pDMAInstDefs))
	{
		xil_printf("Device configured as SG mode.\r\n");
		return XST_FAILURE;
	}

	// Disable interrupts, we use polling mode
	XAxiDma_IntrDisable(pDMAInstDefs, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(pDMAInstDefs, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

	return XST_SUCCESS;
}

/*********************** Square Root Functions *************************/

void SquareRootSw(int* pDst, int* pSrc, unsigned int size)
{
	int* p;

	char condition;
	int j, dtemp, rtemp, qtemp, r, q;
	int word_size = 32;
	int fullmask = 0;
	for (j = 0; j < word_size; j++) {
		fullmask = fullmask << 1 | 0x1;
	}

	for (p = pSrc; p < pSrc + size; p++, pDst++) {
		dtemp = *p;
		r = 0;
		q = 0;
		rtemp = 0;
		qtemp = 0;
        for (j = 0; j < word_size/2; j++) {
            rtemp = ((r<<2) & (fullmask ^ 0x3)) | ((dtemp>>(word_size-2)) & 0x3);
            qtemp = ((q<<2) & (fullmask ^ 0x3)) | 0x1;
            condition = rtemp < qtemp;

            dtemp = (dtemp<<2) & fullmask;
            if(condition) {
                r = rtemp;
                q = q<<1;
            }
            else {
                r = rtemp - qtemp;
                q = (q<<1) | 0x1;
            }
        }

		int mask1 = fullmask, mask2 = 0;
		for (j = 0; j < word_size/2; j++) {
			mask1 = mask1 << 1 | 0;
			mask2 = mask2 << 1 | 0x1;
		}

		if (r >> word_size/2 > 0) {
			r = mask2;
		}
		else {
			r = r & mask2;
		}
		r = r << word_size/2;

		//*pDst = (r & 0xFFFF0000) | (q & 0x0000FFFF);
		*pDst = (r & mask1) | (q & mask2);

    }
}

// pDst -> result (sqrt estimation + remainer) of the software/hardware
// pSrc -> original values
bool CheckSquareRoot(int* pDst, int* pSrc, unsigned int size)
{
	int* p;
	int word_size = 32;

	for (p = pSrc; p < pSrc + size; p++, pDst++)
	{
		int q = floor(sqrt(*p));
		int r = *p - (int)(pow(q,2));

		if (r >> word_size/2 > 0) {
			r = 0x0000FFFF;
		}
		else {
			r = r & 0x0000FFFF;
		}
		r = r << word_size/2;

		int res = (r & 0xFFFF0000) | (q & 0x0000FFFF);
		if (*pDst!=res) {
			return FALSE;
		}

	}

	return TRUE;
}

/*****************************  Helper Functions *****************************/

void PrintDataArray(int* pData, unsigned int size, unsigned char printResults)
{
	int* p;
	int word_size = 32;
	int bottomHalfMask = 0;
	int j = 0;
	for (j = 0; j < word_size/2; j++) {
		bottomHalfMask = bottomHalfMask << 1 | 0x1;
	}

	/* Raw Computed Output */
	xil_printf("\n\r");
	for (p = pData; p < pData + size; p++)
	{
		xil_printf("%08x  ", *p);
	}
	if (printResults) {
		/* Square Root (Quotient) Value */
		xil_printf("\n\n\rSquare Root (Quotient) Value\n\r");
		for (p = pData; p < pData + size; p++)
		{
			xil_printf("%08x  ", (*p) & bottomHalfMask);
		}
		/* (Pseudo-)Remainer Value */
		xil_printf("\n\rRemainer Value\n\r");
		for (p = pData; p < pData + size; p++)
		{
			int tempRem = ((*p)>>(word_size/2)) & bottomHalfMask;
			if (tempRem == bottomHalfMask)
			{
				xil_printf("OF-MACRO  ");
			}
			else {
				xil_printf("%08x  ", tempRem);
			}
		}
	}
}

void ResetPerformanceTimer()
{
	XTmrCtr_Disable(XPAR_TMRCTR_0_BASEADDR, 0);
	XTmrCtr_SetLoadReg(XPAR_TMRCTR_0_BASEADDR, 0, 0x00000001);
	XTmrCtr_LoadTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, 0);
	XTmrCtr_SetControlStatusReg(XPAR_TMRCTR_0_BASEADDR, 0, 0x00000000);
}

void RestartPerformanceTimer()
{
	ResetPerformanceTimer();
	XTmrCtr_Enable(XPAR_TMRCTR_0_BASEADDR, 0);
}

unsigned int GetPerformanceTimer()
{
	return XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, 0);
}

unsigned int StopAndGetPerformanceTimer()
{
	XTmrCtr_Disable(XPAR_TMRCTR_0_BASEADDR, 0);
	return GetPerformanceTimer();
}

/******************************  Main Functions ******************************/

int main()
{
	int status;
	XAxiDma dmaInstDefs;

	int srcData[N], dstData[N];
	unsigned int timeElapsed;

	xil_printf("\r\nSquare Root Program\n\rPaulo Vasconcelos, Pedro Teixeira 2020\n");
	init_platform();

	xil_printf("\r\nFilling memory with pseudo-random data. Seed is %d.", SEED_VALUE);
	RestartPerformanceTimer();
	srand(SEED_VALUE);
	for (int i = 0; i < N; i++)
	{
		srcData[i] = rand();
	}

	//srcData[N-1] = TEST_VALUE;

	timeElapsed = StopAndGetPerformanceTimer();
	xil_printf("\n\rMemory initialization time: %d microseconds",
			   timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));
	PrintDataArray(srcData, min(8, N), FALSE);
	xil_printf("\n\r");

	// Software only
	xil_printf("\r\n----------------------------------------------------------------------\n\rSoftware only square root\n");
	RestartPerformanceTimer();
	SquareRootSw(dstData, srcData, N);
	timeElapsed = StopAndGetPerformanceTimer();
	xil_printf("\n\rExecution time: %d microseconds",
			   timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));
	PrintDataArray(dstData, min(8, N), TRUE);
	xil_printf("\n\n\rChecking result: %s\n\r",
			   CheckSquareRoot(dstData, srcData, N) ? "OK" : "Error");

	xil_printf("\r\n----------------------------------------------------------------------\n\rHardware assisted square root\n\n\rConfiguring DMA...");
	status = DMAConfig(DMA_DEVICE_ID, &dmaInstDefs);
	if (status != XST_SUCCESS)
	{
		xil_printf("\r\nConfiguration failed.");
		return XST_FAILURE;
	}
	xil_printf("\r\nDMA running...\n");

	// DMA and Hardware assisted
	RestartPerformanceTimer();
	status = XAxiDma_SimpleTransfer(&dmaInstDefs,(UINTPTR) dstData, N * sizeof(int),
									XAXIDMA_DEVICE_TO_DMA);
	status = XAxiDma_SimpleTransfer(&dmaInstDefs,(UINTPTR) srcData, N * sizeof(int),
									XAXIDMA_DMA_TO_DEVICE);
	if (status != XST_SUCCESS)
	{
		xil_printf("\r\nDMA transfer failed.");
		return XST_FAILURE;
	}
	while ((XAxiDma_Busy(&dmaInstDefs, XAXIDMA_DEVICE_TO_DMA)) ||
		   (XAxiDma_Busy(&dmaInstDefs, XAXIDMA_DMA_TO_DEVICE)))
	{
		/* Wait */
	}
	timeElapsed = StopAndGetPerformanceTimer();
	xil_printf("\n\rExecution time: %d microseconds",
			   timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));
	PrintDataArray(dstData, min(8, N), TRUE);
	xil_printf("\n\n\rChecking result: %s\n\r",
			   CheckSquareRoot(dstData, srcData, N) ? "OK" : "Error");

	cleanup_platform();
	return XST_SUCCESS;
}
