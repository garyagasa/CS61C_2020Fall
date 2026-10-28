# mulhu 指令测试（高位乘法，无符号数）

# 1. 小数 * 小数（结果高32位应为0）
addi t0, x0, 114
addi t1, x0, 514
mulhu t2, t0, t1      # t2 = 0

# # 2. 大数 * 小数
# lui t0, 0xfffff
# addi t0, t0, -1       # t0 = 0xffffffff
# addi t1, x0, 2
# mulhu t2, t0, t1      # t2 = 1

# # 3. 小数 * 大数
# addi t0, x0, 2
# lui t1, 0xfffff
# addi t1, t1, -1       # t1 = 0xffffffff
# mulhu t2, t0, t1      # t2 = 1

# # 4. 大数 * 大数
# lui t0, 0xfffff
# addi t0, t0, -1       # t0 = 0xffffffff
# lui t1, 0xfffff
# addi t1, t1, -1       # t1 = 0xffffffff
# mulhu t2, t0, t1      # t2 = 0xfffffffe

# 5. 0 * 任意数
addi t0, x0, 0
addi t1, x0, 123
mulhu t2, t0, t1      # t2 = 0

# 6. 任意数 * 0
addi t0, x0, 456
addi t1, x0, 0
mulhu t2, t0, t1      # t2 = 0

# 7. 目标寄存器和源寄存器重叠
addi t0, x0, 114
addi t1, x0, 514
mulhu t0, t0, t1      # t0 = 0

# # 8. 边界值 0xffffffff * 0x80000000
# lui t0, 0xfffff
# addi t0, t0, -1       # t0 = 0xffffffff
# lui t1, 0x80000       # t1 = 0x80000000
# mulhu t2, t0, t1      # t2 = 0x7fffffff

# # 9. 边界值 0xffffffff * 0x7fffffff
# lui t0, 0xfffff
# addi t0, t0, -1       # t0 = 0xffffffff
# lui t1, 0x7ffff       # t1 = 0x7ffff000
# addi t1, t1, -1       # t1 = 0x7fffffff
# mulhu t2, t0, t1      # t2 = 0x7ffffffe
