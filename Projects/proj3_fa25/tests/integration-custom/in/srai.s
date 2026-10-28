addi t0, x0, -1     # 0xFFFF
srai t1, t0, 4      ## 0xFFFF

addi t0, x0, 6      # 'b0110
srai t1, t0, 2      ## 'b0001

addi t0, x0, 5      # 'b0101
srai t1, t0, 3      ## 'b0000

addi t0, x0, 9      # 'b1001
srai t1, t0, 0      ## 'b1001