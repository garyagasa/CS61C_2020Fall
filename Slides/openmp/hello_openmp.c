#include "omp.h"

int main(){
    /*Serial Execution*/
    for(int i = 0; i < 100; i++){
        printf("Hello OpenMP");
    }

    /*OpenMP Parallel*/
    #pragma omp parallel for
    for(int i = 0; i < 100; i++){
        printf("Hello OpenMP");
    }
    return 0;
}