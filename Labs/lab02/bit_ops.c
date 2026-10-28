#include <stdio.h>
#include "bit_ops.h"

/* Returns the Nth bit of X. Assumes 0 <= N <= 31. */
unsigned get_bit(unsigned x, unsigned n) {
    /* YOUR CODE HERE */
	int x_rs = x >> n;
	int ret = 1 & x_rs;
    return ret; /* UPDATE WITH THE CORRECT RETURN VALUE*/
}

/* Set the nth bit of the value of x to v. Assumes 0 <= N <= 31, and V is 0 or 1 */
void set_bit(unsigned *x, unsigned n, unsigned v) {
    /* YOUR CODE HERE */
	int mask_1 = 1 << n;
	int val_1 = *x | mask_1;
	int val_0 = *x & (~mask_1);
	int signal_1 = ~v + 1;
	*x = (signal_1 & val_1) | (~signal_1 & val_0);
}

/* Flips the Nth bit in X. Assumes 0 <= N <= 31.*/
void flip_bit(unsigned *x, unsigned n) {
    /* YOUR CODE HERE */
	unsigned n_bit = get_bit(*x, n);
	set_bit(x, n, !n_bit);
}

