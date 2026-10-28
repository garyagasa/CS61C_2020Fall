# mul 指令测试

# 1. 正数 * 正数
addi t0, x0, 2
addi t1, x0, 3
mul t2, t0, t1      # t2 = 6

# 2. 正数 * 负数
addi t0, x0, 4
addi t1, x0, -5
mul t2, t0, t1      # t2 = -20

# 3. 负数 * 负数
addi t0, x0, -7
addi t1, x0, -8
mul t2, t0, t1      # t2 = 56

# 4. 任意数 * 0
addi t0, x0, 123
addi t1, x0, 0
mul t2, t0, t1      # t2 = 0

# 5. 0 * 任意数
addi t0, x0, 0
addi t1, x0, 456
mul t2, t0, t1      # t2 = 0

# 6. 1 * 任意数
addi t0, x0, 1
addi t1, x0, 789
mul t2, t0, t1      # t2 = 789

# 7. -1 * 任意数
addi t0, x0, -1
addi t1, x0, 42
mul t2, t0, t1      # t2 = -42

# # 8. 边界值相乘
# lui t0, 0x7ffff
# addi t0, t0, -1     # t0 = 0x7fffffff (INT_MAX)
# addi t1, x0, 2
# mul t2, t0, t1      # t2 = 0xfffffffe

# lui t0, 0x80000     # t0 = 0x80000000 (INT_MIN)
# addi t1, x0, 2
# mul t2, t0, t1      # t2 = 0x00000000

# 9. 自己和自己相乘
addi t0, x0, 9
mul t2, t0, t0      # t2 = 81

# 10. 目标寄存器和源寄存器重叠
addi t0, x0, 6
addi t1, x0, 7
mul t0, t0, t1      # t0 = 42
