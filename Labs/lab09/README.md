### Lab 9: Thread Level Parallelism: OpenMP

#### Exercise 1: Hello World
```c
int main() {
    #pragma omp parallel
    {
        int thread_id = omp_get_thread_num();
        printf("hello world from thread %d\n", thread_id);
    }
}
```
- `#pragma` tells the compiler that the rest of the line is a directive.
- `omp` declares that the directive is for OpenMP.
- `parallel` says that the following block statement -- the part inside the curly braces ({/}) -- should be executed in parallel by different threads.

**Running the Program**
```bash
make hello
./hello
```
If you run `./hello` a couple of times, you may notice that the printed numbers are not always in increasing order and will most likely vary across runs. This is because we didn't specify any sort of synchronization options, so OpenMP will not enforce any execution order. (More on that later.) It is also important to note that the variable `thread_id` is defined inside the parallel block, which means that each thread has its own copy of `thread_id`. In general with OpenMP, variables declared inside the parallel block will be private to each thread, but variables declared outside a parallel block will be shared across all threads. There are ways to override this, but more on that later.
```bash
gary@LAPTOP-1P7N3FS9:/mnt/c/Users/wsq/Desktop/26WinterDiy/CS61C/Labs/lab09$ ./hello
 hello world 26
 hello world 10
 hello world 8
 hello world 13
 hello world 9
 hello world 2
 hello world 16
 hello world 25
 hello world 1
 hello world 29
 hello world 15
 hello world 17
 hello world 20
 hello world 0
 hello world 22
 hello world 30
 hello world 18
 hello world 28
 hello world 19
 hello world 24
 hello world 27
 hello world 23
 hello world 21
 hello world 3
 hello world 5
 hello world 6
 hello world 7
 hello world 4
 hello world 11
 hello world 12
 hello world 31
 hello world 14
```
#### Exercise 2: Vector Addition
```c
// Adjacent Method
void v_add_optimized_adjacent(double* x, double* y, double* z);
```
```c
// Chunks Method
void v_add_optimized_chunks(double* x, double* y, double* z);
```
```bash
make v_add
./v_add
```
```bash
gary@LAPTOP-1P7N3FS9:/mnt/c/Users/wsq/Desktop/26WinterDiy/CS61C/Labs/lab09$ ./v_add
Naive: 32 threads took 0.995223 seconds
Optimized adjacent: 1 thread(s) took 0.446379 seconds
Optimized adjacent: 2 thread(s) took 0.410944 seconds
Optimized adjacent: 3 thread(s) took 0.428609 seconds
Optimized adjacent: 4 thread(s) took 0.313247 seconds
Optimized adjacent: 5 thread(s) took 0.325863 seconds
Optimized adjacent: 6 thread(s) took 0.369346 seconds
Optimized adjacent: 7 thread(s) took 0.518533 seconds
Optimized adjacent: 8 thread(s) took 0.597800 seconds
Optimized adjacent: 9 thread(s) took 0.606295 seconds
Optimized adjacent: 10 thread(s) took 0.566011 seconds
Optimized adjacent: 11 thread(s) took 0.506576 seconds
Optimized adjacent: 12 thread(s) took 0.454109 seconds
Optimized adjacent: 13 thread(s) took 0.501460 seconds
Optimized adjacent: 14 thread(s) took 0.453922 seconds
Optimized adjacent: 15 thread(s) took 0.400246 seconds
Optimized adjacent: 16 thread(s) took 0.428341 seconds
Optimized adjacent: 17 thread(s) took 0.348603 seconds
Optimized adjacent: 18 thread(s) took 0.359527 seconds
Optimized adjacent: 19 thread(s) took 0.361016 seconds
Optimized adjacent: 20 thread(s) took 0.299279 seconds
Optimized adjacent: 21 thread(s) took 0.296301 seconds
Optimized adjacent: 22 thread(s) took 0.298092 seconds
Optimized adjacent: 23 thread(s) took 0.289585 seconds
Optimized adjacent: 24 thread(s) took 0.273022 seconds
Optimized adjacent: 25 thread(s) took 0.291996 seconds
Optimized adjacent: 26 thread(s) took 0.282044 seconds
Optimized adjacent: 27 thread(s) took 0.268842 seconds
Optimized adjacent: 28 thread(s) took 0.261658 seconds
Optimized adjacent: 29 thread(s) took 0.252433 seconds
Optimized adjacent: 30 thread(s) took 0.256526 seconds
Optimized adjacent: 31 thread(s) took 0.258493 seconds
Optimized adjacent: 32 thread(s) took 0.362493 seconds
Optimized chunks: 1 thread(s) took 0.374304 seconds
Optimized chunks: 2 thread(s) took 0.202324 seconds
Optimized chunks: 3 thread(s) took 0.165063 seconds
Optimized chunks: 4 thread(s) took 0.135369 seconds
Optimized chunks: 5 thread(s) took 0.122318 seconds
Optimized chunks: 6 thread(s) took 0.114048 seconds
Optimized chunks: 7 thread(s) took 0.109045 seconds
Optimized chunks: 8 thread(s) took 0.104712 seconds
Optimized chunks: 9 thread(s) took 0.107011 seconds
Optimized chunks: 10 thread(s) took 0.113798 seconds
Optimized chunks: 11 thread(s) took 0.112198 seconds
Optimized chunks: 12 thread(s) took 0.119809 seconds
Optimized chunks: 13 thread(s) took 0.128876 seconds
Optimized chunks: 14 thread(s) took 0.119453 seconds
Optimized chunks: 15 thread(s) took 0.131986 seconds
Optimized chunks: 16 thread(s) took 0.137651 seconds
Optimized chunks: 17 thread(s) took 0.124444 seconds
Optimized chunks: 18 thread(s) took 0.123452 seconds
Optimized chunks: 19 thread(s) took 0.116238 seconds
Optimized chunks: 20 thread(s) took 0.117294 seconds
Optimized chunks: 21 thread(s) took 0.123029 seconds
Optimized chunks: 22 thread(s) took 0.115885 seconds
Optimized chunks: 23 thread(s) took 0.129831 seconds
Optimized chunks: 24 thread(s) took 0.122690 seconds
Optimized chunks: 25 thread(s) took 0.130576 seconds
Optimized chunks: 26 thread(s) took 0.121118 seconds
Optimized chunks: 27 thread(s) took 0.127941 seconds
Optimized chunks: 28 thread(s) took 0.119322 seconds
Optimized chunks: 29 thread(s) took 0.127629 seconds
Optimized chunks: 30 thread(s) took 0.123275 seconds
Optimized chunks: 31 thread(s) took 0.144874 seconds
Optimized chunks: 32 thread(s) took 0.193239 seconds
Congrats! All vector tests passed!
```
##### Question
**Which version of your code runs faster, chunks or adjacent? Why?**
*Chunks performs better than adjacent because adjacent indexing is more susceptible to false sharing: when different threads write to different elements in the same cache block in their own cache.*

#### Exercise 3: Dot Product

The next task is to compute the dot product of two vectors. At first glance, implementing this might seem not too different from v_add, since we should now just perform elementwise multiplication instead of addition. The challenge is how to add the products into one variable (aka reduction) to get our final answer. If multiple threads try to add their results to the same variable at the same time, it will lead to a data race which will result in an incorrect result.

One solution is to use a critical section. The code in a critical section can only be executed by a single thread at any given time. Thus, having a critical section naturally prevents multiple threads from reading and writing to the same data, a problem that would otherwise lead to data races. OpenMP provides the `critical` primitive to allow you to perform computations within a critical section. An implementation, `dotp_naive()` in `omp_apps.c`, protects the sum with a critical section.

```c
double dotp_naive(double* x, double* y, int arr_size) {
    double global_sum = 0.0;
    #pragma omp parallel
    {
        #pragma omp for
        for (int i = 0; i < arr_size; i++)
            #pragma omp critical
            global_sum += x[i] * y[i];
    }
    return global_sum;
}
```
Try running the tests:
```bash
make dotp
./dotp
```
Notice how the performance gets much worse as the number of threads go up? By putting all of the work of reduction in a critical section, we have flattened the parallelism and made it so only one thread can do useful work at a time (not exactly the idea behind thread-level parallelism). This contention is problematic; each thread is constantly fighting for the critical section and only one is making any progress at any given time. As the number of threads go up, so does the contention, and the performance pays the price. Can we reduce the number of times that each thread needs to use a critical section?

OpenMP has a built in way to reduce this problem through the use of the `reduction` keyword. The reduction keyword will increase the parallelizability of your code by automatically reducing the amount of code contained within the critical section. To use this keyword, you must specify the the variable that should be in a critical section and the operation being performed on that variable. Here is the code with the reduction keyword:

```c
double dotp_reduction_optimized(double* x, double* y, int arr_size) {
   double global_sum = 0.0;
   #pragma omp parallel
   {
       #pragma omp for reduction(+:global_sum)
       for (int i = 0; i < arr_size; i++) {
           global_sum += x[i] * y[i];
       }
   }
   return global_sum;
}
```
Here, the variable that should only be accessed by one thread at a time is `global_sum` and the operation being performed on it is addtion (`+`).

```bash
gary@LAPTOP-1P7N3FS9:/mnt/c/Users/wsq/Desktop/26WinterDiy/CS61C/Labs/lab09$ ./dotp
Naive: 1 thread took 2.696681 seconds
Manual Optimized: 1 thread(s) took 0.452108 seconds
Manual Optimized: 2 thread(s) took 0.236650 seconds
Manual Optimized: 3 thread(s) took 0.173286 seconds
Manual Optimized: 4 thread(s) took 0.133457 seconds
Manual Optimized: 5 thread(s) took 0.109372 seconds
Manual Optimized: 6 thread(s) took 0.089511 seconds
Manual Optimized: 7 thread(s) took 0.082850 seconds
Manual Optimized: 8 thread(s) took 0.077293 seconds
Manual Optimized: 9 thread(s) took 0.099891 seconds
Manual Optimized: 10 thread(s) took 0.092391 seconds
Manual Optimized: 11 thread(s) took 0.086678 seconds
Manual Optimized: 12 thread(s) took 0.081326 seconds
Manual Optimized: 13 thread(s) took 0.074892 seconds
Manual Optimized: 14 thread(s) took 0.074009 seconds
Manual Optimized: 15 thread(s) took 0.073245 seconds
Manual Optimized: 16 thread(s) took 0.069829 seconds
Manual Optimized: 17 thread(s) took 0.067071 seconds
Manual Optimized: 18 thread(s) took 0.065629 seconds
Manual Optimized: 19 thread(s) took 0.062111 seconds
Manual Optimized: 20 thread(s) took 0.058003 seconds
Manual Optimized: 21 thread(s) took 0.058044 seconds
Manual Optimized: 22 thread(s) took 0.053059 seconds
Manual Optimized: 23 thread(s) took 0.051576 seconds
Manual Optimized: 24 thread(s) took 0.050962 seconds
Manual Optimized: 25 thread(s) took 0.050737 seconds
Manual Optimized: 26 thread(s) took 0.048422 seconds
Manual Optimized: 27 thread(s) took 0.048100 seconds
Manual Optimized: 28 thread(s) took 0.048763 seconds
Manual Optimized: 29 thread(s) took 0.053922 seconds
Manual Optimized: 30 thread(s) took 0.047367 seconds
Manual Optimized: 31 thread(s) took 0.051757 seconds
Manual Optimized: 32 thread(s) took 0.094989 seconds
Reduction Optimized: 1 thread(s) took 0.462804 seconds
Reduction Optimized: 2 thread(s) took 0.254148 seconds
Reduction Optimized: 3 thread(s) took 0.170579 seconds
Reduction Optimized: 4 thread(s) took 0.130612 seconds
Reduction Optimized: 5 thread(s) took 0.107770 seconds
Reduction Optimized: 6 thread(s) took 0.087925 seconds
Reduction Optimized: 7 thread(s) took 0.079789 seconds
Reduction Optimized: 8 thread(s) took 0.077603 seconds
Reduction Optimized: 9 thread(s) took 0.095645 seconds
Reduction Optimized: 10 thread(s) took 0.090064 seconds
Reduction Optimized: 11 thread(s) took 0.083893 seconds
Reduction Optimized: 12 thread(s) took 0.078263 seconds
Reduction Optimized: 13 thread(s) took 0.073030 seconds
Reduction Optimized: 14 thread(s) took 0.070467 seconds
Reduction Optimized: 15 thread(s) took 0.069860 seconds
Reduction Optimized: 16 thread(s) took 0.069844 seconds
Reduction Optimized: 17 thread(s) took 0.065020 seconds
Reduction Optimized: 18 thread(s) took 0.066340 seconds
Reduction Optimized: 19 thread(s) took 0.061526 seconds
Reduction Optimized: 20 thread(s) took 0.060950 seconds
Reduction Optimized: 21 thread(s) took 0.056081 seconds
Reduction Optimized: 22 thread(s) took 0.055543 seconds
Reduction Optimized: 23 thread(s) took 0.053673 seconds
Reduction Optimized: 24 thread(s) took 0.050938 seconds
Reduction Optimized: 25 thread(s) took 0.049705 seconds
Reduction Optimized: 26 thread(s) took 0.049598 seconds
Reduction Optimized: 27 thread(s) took 0.048741 seconds
Reduction Optimized: 28 thread(s) took 0.046643 seconds
Reduction Optimized: 29 thread(s) took 0.045472 seconds
Reduction Optimized: 30 thread(s) took 0.054747 seconds
Reduction Optimized: 31 thread(s) took 0.073860 seconds
Reduction Optimized: 32 thread(s) took 0.094043 seconds
Congrats! All dotp tests passed
```

- `#pragma omp parallel { ... }`：创建线程；括号里的代码“复制”给每个线程执行。
- `#pragma omp for`：只分配后面这个 for 的迭代给各线程，是工作划分。
- `#pragma omp for reduction(+:var)`：在分配迭代的同时，对 var 做自动归约，每个线程私有一份，最后合并。
- `#pragma omp critical`：显式的临界区，任意位置都可以用，但会让这段代码一次只能一个线程进入。