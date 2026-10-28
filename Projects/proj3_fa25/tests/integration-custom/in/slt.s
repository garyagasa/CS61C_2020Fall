# slt 指令测试

# 1. 正数小于正数
addi t0, x0, 1
addi t1, x0, 2
slt t2, t0, t1      # t2 = 1

# 2. 正数大于正数
addi t0, x0, 5
addi t1, x0, 3
slt t2, t0, t1      # t2 = 0

# 3. 负数小于正数
addi t0, x0, -1
addi t1, x0, 1
slt t2, t0, t1      # t2 = 1

# 4. 正数小于负数
addi t0, x0, 1
addi t1, x0, -1
slt t2, t0, t1      # t2 = 0

# 5. 负数小于负数
addi t0, x0, -5
addi t1, x0, -2
slt t2, t0, t1      # t2 = 1

# 6. 负数大于负数
addi t0, x0, -2
addi t1, x0, -5
slt t2, t0, t1      # t2 = 0

# 7. 相等
addi t0, x0, 7
addi t1, x0, 7
slt t2, t0, t1      # t2 = 0

# 8. 自己和自己比较
addi t0, x0, -3
slt t2, t0, t0      # t2 = 0

# 9. x0和正数
addi t1, x0, 4
slt t2, x0, t1      # t2 = 1

# 10. x0和负数
addi t1, x0, -4
slt t2, x0, t1      # t2 = 0

# 11. 目标寄存器和源寄存器重叠
addi t0, x0, 2
addi t1, x0, 3
slt t0, t0, t1      # t0 = 1

# # 12. 边界值
# lui t0, 0x7ffff
# addi t0, t0, -1     # t0 = 0x7fffffff (INT_MAX)
# lui t1, 0x80000     # t1 = 0x80000000 (INT_MIN)
# slt t2, t1, t0      # t2 = 1
# slt t2, t0, t1      # t2 = 0
