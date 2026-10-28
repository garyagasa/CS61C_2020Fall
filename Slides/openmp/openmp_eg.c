#include <stdio.h>
#include <omp.h>

int main(){
    printf("max thread number = %d\n", omp_get_max_threads());
    omp_set_num_threads(4);
    int a[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int N = sizeof(a) / sizeof(int);

    #pragma omp parallel for
    for(int i = 0; i < N; i++){
        printf("thread %d, i = %2d\n",
            omp_get_thread_num(), i);
        a[i] = a[i] + 10 * omp_get_thread_num();
    }

    for(int i = 0; i < N; i++){
        printf("%02d ", a[i]);
    }
    printf("\n");
}