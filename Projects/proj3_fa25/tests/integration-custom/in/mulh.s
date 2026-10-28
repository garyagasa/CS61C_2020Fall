# mulh 指令测试（高位乘法，符号数）

# 1. 正数 * 正数（结果高32位应为0）
addi t0, x0, 114
addi t1, x0, 514
mulh t2, t0, t1      # t2 = 0

# 2. 负数 * 正数
addi t0, x0, -1
addi t1, x0, 2
mulh t2, t0, t1      # t2 = -1

# 3. 正数 * 负数
addi t0, x0, 2
addi t1, x0, -1
mulh t2, t0, t1      # t2 = -1

# 4. 负数 * 负数
addi t0, x0, -2
addi t1, x0, -3
mulh t2, t0, t1      # t2 = 0

# # 5. 边界值 INT_MAX * INT_MAX
# lui t0, 0x7ffff
# addi t0, t0, -1     # t0 = 0x7fffffff
# mulh t2, t0, t0      # t2 = 0x3fffffff

# # 6. 边界值 INT_MIN * INT_MIN
# lui t0, 0x80000     # t0 = 0x80000000
# mulh t2, t0, t0      # t2 = 0x40000000

# # 7. INT_MAX * INT_MIN
# lui t0, 0x7ffff
# addi t0, t0, -1     # t0 = 0x7fffffff
# lui t1, 0x80000     # t1 = 0x80000000
# mulh t2, t0, t1      # t2 = 0xc0000000

# 8. 0 * 任意数
addi t0, x0, 0
addi t1, x0, 123
mulh t2, t0, t1      # t2 = 0

# 9. 任意数 * 0
addi t0, x0, 456
addi t1, x0, 0
mulh t2, t0, t1      # t2 = 0

# 10. 目标寄存器和源寄存器重叠
addi t0, x0, -2
addi t1, x0, 3
mulh t0, t0, t1      # t0 = -1
