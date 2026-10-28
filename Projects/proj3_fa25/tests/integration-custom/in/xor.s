addi t0, x0, 7      # 'b0111
addi t1, x0, 14     # 'd14 = 'b1110     # 'b0110
xor t2, t0, t1

addi t0, x0, 6      # 'b0110
addi t1, x0, 15     # 'd15 = 'b1111     # 'b0110
xor s0, t0, t1

addi t0, x0, 5      # 'b0101
addi t1, x0, 12     # 'd12 = 'b1100     # 'b0100
xor t0, t1, t0

addi t0, x0, 9      # 'b1001
addi t1, x0, 4     # 'd9 = 'b0100     # 'b0000
xor s1, t1, t0