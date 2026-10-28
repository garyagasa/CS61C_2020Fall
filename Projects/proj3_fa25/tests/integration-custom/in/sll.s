addi t0, x0, 7      # 'b0111
addi t1, x0, 1
sll t1, t0, t1      ## 'b1110

addi t0, x0, 6      # 'b0110
addi t1, x0, 2
sll t2, t0, t1     ## 'b011000

addi t0, x0, 5      # 'b0101
addi t1, x0, 3
sll s1, t0, t1      ## 'b0101000

addi t0, x0, 9      # 'b1001
addi s0, x0, 0
sll t2, t0, s0      ## 'b1001