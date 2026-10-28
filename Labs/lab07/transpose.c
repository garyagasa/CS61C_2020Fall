#include "transpose.h"

/* The naive transpose function as a reference. */
void transpose_naive(int n, int blocksize, int *dst, int *src) {
    for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++) {
            dst[y + x * n] = src[x + y * n];
        }
    }
}

/* Implement cache blocking below. You should NOT assume that n is a
 * multiple of the block size. */
void transpose_blocking(int n, int blocksize, int *dst, int *src) {
    // YOUR CODE HERE
    // loop of the whole block
    for(int x_start = 0; x_start < n; x_start += blocksize){
        for(int y_start = 0; y_start < n; y_start += blocksize){
            // loop inside a specific block
            for(int i = 0; i < blocksize; i++){
                int x = x_start + i;
                /*Boundary Check of x*/
                if(x >= n)
                    continue;
                for(int j = 0; j < blocksize; j++){
                    int y = y_start + j;
                    /*Boundary Check of y*/
                    if(y >= n)
                        continue;
                    dst[y + x * n] = src[x + y * n];
                }
            }
        }
    }
}
