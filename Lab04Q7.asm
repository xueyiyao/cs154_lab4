.text
jerry:
	addi $t0, $a0, 0x2
	addi $t1, $zero, 0x3
	mult $t0, $t1
	mflo $v0
	jr $ra

morty:
	sll $t0, $a0, 0x1
	addi $a0, $t0, 0xFFFFFFFA
	addi $sp, $sp, 0xFFFFFFFC
	sw $ra, 0($sp)
	jal jerry
	lw $ra, 0($sp)
	addi $sp, $sp, 0x4

	addi $sp, $sp, 0xFFFFFFFC
	sw $s0, 0($sp)
	add $s0, $v0, $zero
	add $a0, $v0, $zero
	addi $sp, $sp, 0xFFFFFFFC
        sw $ra,	0($sp)
	jal jerry
        lw $ra, 0($sp)
        addi $sp, $sp, 0x4
	add $v0, $v0, $s0

	addi $sp, $sp, 0x4
	lw $s0, 0($sp)
	jr $ra

main:
	addi $a0, $zero, 0x5
	addi $sp, $sp, 0xFFFFFFFC
	sw $ra, 0($sp)
	jal morty
	lw $ra, 0($sp)
	addi $sp, $sp, 0x4
	
	sll $a0, $v0, 0x2
	addi $v0, $zero, 0x1
	syscall

	add $a0, $zero, $zero
	addi $v0, $zero, 0xA
	syscall
	
