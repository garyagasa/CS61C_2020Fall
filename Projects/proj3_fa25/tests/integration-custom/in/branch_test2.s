# branch_test2.s
# 更复杂的B-type分支指令测试

# 初始化寄存器
addi t0, x0, 5
addi t1, x0, 10
addi t2, x0, -5
addi t3, x0, 0

# beq: t0 == t3，不跳
beq t0, t3, label1
addi s0, x0, 1
label1:
addi s0, x0, 2

# bne: t0 != t1，跳转
bne t0, t1, label2
addi s1, x0, 3
label2:
addi s1, x0, 4

# blt: t2 < t0，跳转
blt t2, t0, label3
addi s2, x0, 5
label3:
addi s2, x0, 6

# bge: t1 >= t0，跳转
bge t1, t0, label4
addi s3, x0, 7
label4:
addi s3, x0, 8

# bltu: t3 < t1（无符号），跳转
bltu t3, t1, label5
addi s4, x0, 9
label5:
addi s4, x0, 10

# bgeu: t0 >= t2（无符号），跳转
bgeu t0, t2, label6
addi s5, x0, 11
label6:
addi s5, x0, 12

# 分支嵌套测试
addi t4, x0, 0
outer_loop:
addi t4, t4, 1
blt t4, t1, inner_loop
addi s6, x0, 13
j end_loop
inner_loop:
addi s6, x0, 14
end_loop:
addi s7, x0, 15
