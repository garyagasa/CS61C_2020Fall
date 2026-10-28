#include <stdio.h>
#include <omp.h>

/*Sequential*/
// int main(){
//     const long num_steps = 10000000;
//     double step = 1.0 / ((double)num_steps);
//     double sum = 0.0;
//     for(int i = 0; i < num_steps; i++){
//         double x = (i + 0.5) * step;
//         sum += 4.0 * step / (1.0 + x*x);
//     }
//     printf("pi = %6.12f\n", sum);
//     return 0;
// }

/*Parallel 1：BUG: Data Competition of "sum" variable*/
// int main(){
//     omp_set_num_threads(4);
//     const long num_steps = 1000000;
//     double step = 1.0 / ((double)num_steps);
//     double sum = 0.0;
  
//     #pragma omp parallel for
//     for(int i = 0; i < num_steps; i++){
//         double x = (i + 0.5) * step;
//         sum += 4.0 * step / (1.0 + x*x);
//     }
//     printf("pi = %6.12f\n", sum);
//     return 0;
// }

/*Parallel 2: BUG: Data Competition of "pi" variable*/
// int main(){
//     const int NUM_THREADS = 1000;
//     const long num_steps = 100000;
//     double step = 1.0 / ((double)num_steps);
//     double sum[NUM_THREADS];

//     for(int i = 0; i < NUM_THREADS; i++)
//         sum[i] = 0;

//     double pi = 0;
//     omp_set_num_threads(NUM_THREADS);

//     #pragma omp parallel
//     {
//         int id = omp_get_thread_num();
//         for(int i = id; i < num_steps; i += NUM_THREADS){
//             double x = (i + 0.5) * step;
//             sum[id] += 4.0 * step / (1.0 + x*x);
//             // printf("i = %3d, id = %3d\n", i, id);
//         }
//         pi += sum[id];
//     }

//     printf("pi = %6.12f\n", pi);
//     return 0;
// }

/*Parallel 3*/
int main(){
    const int NUM_THREADS = 32;
    const long num_steps = 10000000;
    double step = 1.0 / ((double)num_steps);
    double sum[NUM_THREADS];

    for(int i = 0; i < NUM_THREADS; i++)
        sum[i] = 0;

    omp_set_num_threads(NUM_THREADS);

    #pragma omp parallel
    {
        int id = omp_get_thread_num();
        for(int i = id; i < num_steps; i += NUM_THREADS){
            double x = (i + 0.5) * step;
            sum[id] += 4.0 * step / (1.0 + x*x);
            // printf("i = %3d, id = %3d\n", i, id);
        }
    }

    double pi = 0;
    for(int i = 0; i < NUM_THREADS; i++)
        pi += sum[i];
    
    printf("pi = %6.12f\n", pi);
    return 0;
}