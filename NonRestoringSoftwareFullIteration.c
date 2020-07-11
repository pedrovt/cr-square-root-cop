/*
    Non-Restorg Algorithm - Software Implementation
    https://scholarworks.rit.edu/cgi/viewcontent.cgi?article=10865&context=theses

    Author: Paulo Vasconcelos
    Author: Pedro Teixeira
*/

#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <time.h>

#define TEST_VALUES_AMOUNT 6
#define WORD_SIZE 16

int main() {
    // Change input values and expected values in order to match testbench values
    int d[TEST_VALUES_AMOUNT]         = {4, 10, 73, 127, 128, 57628};
    int r[TEST_VALUES_AMOUNT]         = {0,  0,  0,   0,   0,     0};
    int q[TEST_VALUES_AMOUNT]         = {0,  0,  0,   0,   0,     0};
    int dExpected[TEST_VALUES_AMOUNT] = {0,  0,  0,   0,   0,     0};
    int rExpected[TEST_VALUES_AMOUNT] = {0,  1,  9,   6,   7,    28};
    int qExpected[TEST_VALUES_AMOUNT] = {2,  3,  8,  11,  11,   240};

    double timeSpent = 0.0;
    int i, j, rtemp, qtemp;
    bool condition;
    
    clock_t start = clock();
    for (i = 0; i < TEST_VALUES_AMOUNT; i++) {
        for (j = 0; j < WORD_SIZE/2; j++) {
            rtemp = ((r[i]<<2) & 0xFFFC) | ((d[i]>>14) & 0x0003);
            qtemp = ((q[i]<<2) & 0xFFFC) | 0x0001;
            condition = rtemp < qtemp;

            d[i] = (d[i]<<2) & 0xFFFF;
            if(condition) {
                r[i] = rtemp;
                q[i] = q[i]<<1;
            }
            else {
                r[i] = rtemp - qtemp;
                q[i] = (q[i]<<1) | 0x0001;
            }
        }
    }
    clock_t stop = clock();

    // Assertions
    for (i = 0; i < TEST_VALUES_AMOUNT; i++) {
        assert(dExpected[i] == d[i]);
        assert(rExpected[i] == r[i]);
        assert(qExpected[i] == q[i]);
    }

    timeSpent += (double)(stop-start)/CLOCKS_PER_SEC;
    /*
        Code for timeSpent based on:
        https://www.techiedelight.com/find-execution-time-c-program/
    */

    printf("     Expected | Output\n");
    for (i = 0; i < TEST_VALUES_AMOUNT; i++) {
        printf("d[%d] %8d | %d\n", i, dExpected[i], d[i]);
        printf("r[%d] %8d | %d\n", i, rExpected[i], r[i]);
        printf("q[%d] %8d | %d\n", i, qExpected[i], q[i]);
    }
    printf("\nTime spent: %.2es\n", timeSpent);

    return 0;
}