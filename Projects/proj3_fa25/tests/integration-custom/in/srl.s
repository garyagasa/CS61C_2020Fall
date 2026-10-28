# testing srl instruction
# 1. 右移0位（应保持不变）
addi t0, x0, 15      # t0 = 0b1111
addi t1, x0, 0
srl t2, t0, t1       # t2 = 0b1111

# 2. 右移大于寄存器宽度（只取低5位，32位下等价于右移0位）
addi t0, x0, 31      # t0 = 0b11111
addi t1, x0, 32
srl t2, t0, t1       # t2 = 0b11111

# 3. 右移31位（最高位应为原最低位，其余为0）
addi t0, x0, -1      # t0 = 0xFFFFFFFF
addi t1, x0, 31
srl t2, t0, t1       # t2 = 1

# 4. 右移立即数
addi t0, x0, 0b10000000
addi t1, x0, 7
srl t2, t0, t1       # t2 = 1

# 5. 源寄存器和目标寄存器相同
addi t0, x0, 0b10101010
addi t1, x0, 2
srl t0, t0, t1       # t0 = 0b00101010

# 6. 右移结果为0
addi t0, x0, 1
addi t1, x0, 1
srl t2, t0, t1       # t2 = 0

# 7. 右移负数（逻辑右移，高位补0）
addi t0, x0, -8      # t0 = 0xFFFFFFF8
addi t1, x0, 2
srl t2, t0, t1       # t2 = 0x3FFFFFFE

# 8. 右移x0寄存器
addi t1, x0, 5
srl t2, x0, t1       # t2 = 0

# 9. 右移自身为0
addi t0, x0, 0
addi t1, x0, 10
srl t2, t0, t1       # t2 = 0

# # 10. 右移最大正数
# lui t0, 0x7ffff      # t0 = 0x7ffff000
# addi t0, t0, -1      # t0 = 0x7fffffff
# addi t1, x0, 4
# srl t2, t0, t1       # t2 = 0x07ffffff

# # 11. 右移最大负数
# lui t0, 0x80000      # t0 = 0x80000000
# addi t1, x0, 4
# srl t2, t0, t1       # t2 = 0x08000000