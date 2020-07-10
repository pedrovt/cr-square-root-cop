/*
    Non-Restoring Algorithm - Software Implementation
    https://scholarworks.rit.edu/cgi/viewcontent.cgi?article=10865&context=theses

    Author: Paulo Vasconcelos
    Author: Pedro Teixeira
*/

#include <assert.h>
#include <stdio.h>
#include <time.h>

#define TEST_VALUES_AMOUNT 5
#define WORD_SIZE 16

int main() {
    // Change input values and expected values in order to match testbench values
    int dIn[TEST_VALUES_AMOUNT]         = {0x4000, 0x8000, 0xFC00, 0x0000, 0x0124};
    int rIn[TEST_VALUES_AMOUNT]         = {0x0000, 0x0001, 0x0000, 0x0004, 0x0000};
    int qIn[TEST_VALUES_AMOUNT]         = {0x0000, 0x0001, 0x0001, 0x0002, 0x0000};
    int dExpected[TEST_VALUES_AMOUNT]   = {0x0000, 0x0000, 0xF000, 0x0000, 0x0490};
    int rExpected[TEST_VALUES_AMOUNT]   = {0x0000, 0x0001, 0x0003, 0x0007, 0x0000};
    int qExpected[TEST_VALUES_AMOUNT]   = {0x0001, 0x0003, 0x0002, 0x0005, 0x0000};

    int dOut[TEST_VALUES_AMOUNT] = {0x0000, 0x0000, 0x0000, 0x0000, 0x0000};
    int rOut[TEST_VALUES_AMOUNT] = {0x0000, 0x0000, 0x0000, 0x0000, 0x0000};
    int qOut[TEST_VALUES_AMOUNT] = {0x0000, 0x0000, 0x0000, 0x0000, 0x0000};

    double timeSpent = 0.0;
    int i, rtemp, qtemp;
    bool condition;
    
    clock_t start = clock();
    for (i = 0; i < TEST_VALUES_AMOUNT; i++) {
        dOut[i] = (dIn[i]<<2) & 0xFFFF;
        rtemp = ((rIn[i]<<2) & 0xFFFC) | ((dIn[i]>>14) & 0x0003);
        qtemp = ((qIn[i]<<2) & 0xFFFC) | 0x0001;
        condition = rtemp < qtemp;
        if(condition) {
            rOut[i] = rtemp;
            qOut[i] = qIn[i]<<1
        }
        else {
            rOut[i] = rtemp - qtemp;
            qOut[i] = (qIn[i]<<1) | 0x0001;
        }
    }
    clock_t stop = clock();

    // Assertions
    for (i = 0; i < TEST_VALUES_AMOUNT; i++) {
        assert(dExpected[i] == dOut[i]);
        assert(rExpected[i] == rOut[i]);
        assert(qExpected[i] == qOut[i]);
    }

    timeSpent += (double)(stop-start)/CLOCKS_PER_SECOND;
    /*
        Code for timeSpent based on:
        https://www.techiedelight.com/find-execution-time-c-program/
    */

    return 0;
}