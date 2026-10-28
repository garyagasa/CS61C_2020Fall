# l_type.s
	# 测试各类 L-type 载入指令：lb/lh/lw
	# 要求：不使用 lui，只用 addi 指令构造内存数据

	# 约定：
	# - 使用 s0 作为基址寄存器，指向一段测试用内存区域
	# - 使用 a0–a7 保存不同 load 指令的结果，方便在 Logisim 中观察

	# s0 = 200，作为基址地址
	addi s0, x0, 200

	# 构造字节模式，用于测试 lb
	#  mem[s0+0] = 0x7F  ( 127)
	#  mem[s0+1] = 0xFF  (-1  -> 0xFF)
	#  mem[s0+2] = 0x80  (-128-> 0x80)
	#  mem[s0+3] = 0x00
	addi t0, x0, 127        # 0x7F
	addi t1, x0, -1         # 0xFF
	addi t2, x0, -128       # 0x80
	addi s1, x0, 0          # 0x00

	# 构造半字模式，用于测试 lh
	#  mem[s0+4] = 0x00
	#  mem[s0+5] = 0x80  -> halfword 0x8000 (负数)
	#  mem[s0+6] = 0xFF
	#  mem[s0+7] = 0x7F  -> halfword 0x7FFF (正数)
	addi t3, x0, 0
	addi t4, x0, -128       # 0x80

	# 构造一整个字，用于测试 lw 的符号扩展
	#  mem[s0+8]  = 0x01 (LSB)
	#  mem[s0+9]  = 0x00
	#  mem[s0+10] = 0x00
	#  mem[s0+11] = 0x80 (MSB) -> word 0x80000001 (负数)
	addi t5, x0, 1
	addi t6, x0, -128       # 0x80

	########################################
	#           实际 L-type 测试           #
	########################################

	# Byte 载入：测试符号扩展
	lb   a0, 0(s0)          # a0 =  127  (0x0000007F)

	lb   a2, 1(s0)          # a2 =  -1   (0xFFFFFFFF)

	lb   a4, 2(s0)          # a4 =  -128 (0xFFFFFF80)

	# Halfword 载入：测试符号扩展
	lh   a6, 4(s0)          # a6 = -32768 (0xFFFF8000)

	# 再做一次 halfword 测试，正数情况
	lh   t0, 6(s0)          # t0 =  32767 (0x00007FFF)

	# Word 载入：测试带符号 32 位数据
	lw   t2, 8(s0)          # t2 = 0x80000001 (负数)

	# 程序结束（无需自旋循环，避免 Venus 超时)

