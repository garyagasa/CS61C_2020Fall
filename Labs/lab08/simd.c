#include <time.h>
#include <stdio.h>
#include <x86intrin.h>
#include "simd.h"

long long int sum(int vals[NUM_ELEMS]) {
    clock_t start = clock();

    long long int sum = 0;
    for(unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        for(unsigned int i = 0; i < NUM_ELEMS; i++) {
            if(vals[i] >= 128) {
                sum += vals[i];
            }
        }
    }
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return sum;
}

long long int sum_unrolled(int vals[NUM_ELEMS]) {
    clock_t start = clock();
    long long int sum = 0;

    for(unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        for(unsigned int i = 0; i < NUM_ELEMS / 4 * 4; i += 4) {
            if(vals[i] >= 128) sum += vals[i];
            if(vals[i + 1] >= 128) sum += vals[i + 1];
            if(vals[i + 2] >= 128) sum += vals[i + 2];
            if(vals[i + 3] >= 128) sum += vals[i + 3];
        }

        // TAIL CASE, for when NUM_ELEMS isn't a multiple of 4
        // NUM_ELEMS / 4 * 4 is the largest multiple of 4 less than NUM_ELEMS
        // Order is important, since (NUM_ELEMS / 4) effectively rounds down first
        for(unsigned int i = NUM_ELEMS / 4 * 4; i < NUM_ELEMS; i++) {
            if (vals[i] >= 128) {
                sum += vals[i];
            }
        }
    }
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return sum;
}

long long int sum_simd(int vals[NUM_ELEMS]) {
    clock_t start = clock();
    __m128i _127 = _mm_set1_epi32(127); // This is a vector with 127s in it... Why might you need this?
    long long int result = 0; // This is where you should put your final result!
    /* DO NOT MODIFY ANYTHING ABOVE THIS LINE (in this function) */

    for(unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        /* YOUR CODE GOES HERE */
        
        // Initialize sum vector to {0, 0, 0, 0}
        __m128i sum_vec = _mm_setzero_si128();

        for(unsigned int i = 0; i < NUM_ELEMS / 4 * 4; i += 4) {
            // Load array element vals[i] to vals[i + 4] into a temporary vector register
            __m128i tmp = _mm_loadu_si128((__m128i *)(vals + i));
            // Compare each element to 128
            __m128i mask = _mm_cmpgt_epi32(tmp, _127);
            __m128i masked_tmp = _mm_and_si128(tmp, mask);
            // Add to existing sum vector
            sum_vec = _mm_add_epi32(sum_vec, masked_tmp);
        }

        // Create temporary array to hold values from sum_vec
        // We must store the vector into an array in order to access the individual values (as seen below)
        int tmp_arr[4];
        _mm_storeu_si128((__m128i *) tmp_arr, sum_vec);
        // Collect values from sum_vec in a single integer
        long long int partial = tmp_arr[0] + tmp_arr[1] + tmp_arr[2] + tmp_arr[3];
        result += partial;

        /* Hint: you'll need a tail case. */
        for(unsigned int i = NUM_ELEMS / 4 * 4; i < NUM_ELEMS; i++) {
            if (vals[i] >= 128) {
                result += vals[i];
            }
        }
    }

    /* DO NOT MODIFY ANYTHING BELOW THIS LINE (in this function) */
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return result;
}

long long int sum_simd_unrolled(int vals[NUM_ELEMS]) {
    clock_t start = clock();
    __m128i _127 = _mm_set1_epi32(127);
    long long int result = 0;
    /* DO NOT MODIFY ANYTHING ABOVE THIS LINE (in this function) */

    for(unsigned int w = 0; w < OUTER_ITERATIONS; w++) {
        /* YOUR CODE GOES HERE */
        /* Copy your sum_simd() implementation here, and unroll it */

        // 使用 4 个累加向量增加指令级并行度
        __m128i sum0 = _mm_setzero_si128();
        __m128i sum1 = _mm_setzero_si128();
        __m128i sum2 = _mm_setzero_si128();
        __m128i sum3 = _mm_setzero_si128();

        unsigned int i = 0;

        // 主循环：一次处理 16 个元素（4 个 SIMD 寄存器）
        for (; i + 15 < NUM_ELEMS; i += 16) {
            __m128i v0 = _mm_loadu_si128((__m128i const *)(vals + i));
            __m128i v1 = _mm_loadu_si128((__m128i const *)(vals + i + 4));
            __m128i v2 = _mm_loadu_si128((__m128i const *)(vals + i + 8));
            __m128i v3 = _mm_loadu_si128((__m128i const *)(vals + i + 12));

            __m128i m0 = _mm_cmpgt_epi32(v0, _127);
            __m128i m1 = _mm_cmpgt_epi32(v1, _127);
            __m128i m2 = _mm_cmpgt_epi32(v2, _127);
            __m128i m3 = _mm_cmpgt_epi32(v3, _127);

            sum0 = _mm_add_epi32(sum0, _mm_and_si128(v0, m0));
            sum1 = _mm_add_epi32(sum1, _mm_and_si128(v1, m1));
            sum2 = _mm_add_epi32(sum2, _mm_and_si128(v2, m2));
            sum3 = _mm_add_epi32(sum3, _mm_and_si128(v3, m3));
        }

        // 把 4 个累加向量合并成一个
        __m128i sum_vec = _mm_add_epi32(_mm_add_epi32(sum0, sum1), _mm_add_epi32(sum2, sum3));

        // 第二个 SIMD 尾巴：还可以再按 4 个一组用 SIMD 处理
        for (; i + 3 < NUM_ELEMS; i += 4) {
            __m128i v = _mm_loadu_si128((__m128i const *)(vals + i));
            __m128i m = _mm_cmpgt_epi32(v, _127);
            v = _mm_and_si128(v, m);
            sum_vec = _mm_add_epi32(sum_vec, v);
        }

        // 把向量里的 4 个分量加到一个标量里
        int tmp_arr[4];
        _mm_storeu_si128((__m128i *)tmp_arr, sum_vec);
        long long int partial = (long long)tmp_arr[0] + tmp_arr[1] + tmp_arr[2] + tmp_arr[3];

        // 最后 1~3 个元素用标量处理
        for (; i < NUM_ELEMS; i++) {
            if (vals[i] >= 128) {
                partial += vals[i];
            }
        }

        result += partial;
    }

    /* DO NOT MODIFY ANYTHING BELOW THIS LINE (in this function) */
    clock_t end = clock();
    printf("Time taken: %Lf s\n", (long double)(end - start) / CLOCKS_PER_SEC);
    return result;
}
