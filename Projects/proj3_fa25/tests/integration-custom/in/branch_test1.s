# branch_test1.s
# 测试各种B-type分支指令

# 初始化寄存器
addi t0, x0, 1
addi t1, x0, 2
addi t2, x0, 1
addi t3, x0, -1

# beq: t0 == t2，跳转
beq t0, t2, label_beq
addi s0, x0, 100   # 不跳时执行
label_beq:
addi s0, x0, 200   # 跳转后执行

# bne: t0 != t1，跳转
bne t0, t1, label_bne
addi s1, x0, 300   # 不跳时执行
label_bne:
addi s1, x0, 400   # 跳转后执行

# blt: t3 < t1，跳转
blt t3, t1, label_blt
addi s2, x0, 500   # 不跳时执行
label_blt:
addi s2, x0, 600   # 跳转后执行

# bge: t1 >= t0，跳转
bge t1, t0, label_bge
addi s3, x0, 700   # 不跳时执行
label_bge:
addi s3, x0, 800   # 跳转后执行

# bltu: t0 < t1（无符号），跳转
bltu t0, t1, label_bltu
addi s4, x0, 900   # 不跳时执行
label_bltu:
addi s4, x0, 1000  # 跳转后执行

# bgeu: t1 >= t0（无符号），跳转
bgeu t1, t0, label_bgeu
addi s5, x0, 1100  # 不跳时执行
label_bgeu:
addi s5, x0, 1200  # 跳转后执行

# 连续分支测试
addi t4, x0, 0
loop:
addi t4, t4, 1
blt t4, t1, loop
addi s6, x0, 1300
