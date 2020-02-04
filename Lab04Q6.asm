.data
a:	.word 3, 5, 2, 1, 7
print:	.asciiz " units.\n"

.text
rick:
	sll $t0, $a0, 0x1
	sub $v0, $t0, $a1
	jr $ra

main:
	addi $sp, $sp, 0xFFFFFFF0
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 16($sp)
	
	addi $s1, $zero, 0x2
	la $s0, a
	add $s2, $zero, $zero
	addi $s3, $zero, 0x5
	
loop:	beq $s2, $s3, exit
	sll $t0, $s2, 0x2		#t0 holds offset of value
	add $t1, $s0, $t0		#t1 holds address of value
	lw $t2, 0($t1)			#t2 holds value
	slt $t3, $s1, $t2		#t3 holds 1 if $s1 is less than $t2
	addi $t4, $zero, 0x1		#t4 holds 1
	bne $t3, $t4, else		#branch if t4 and t3 not equal

	add $a0, $t2, $zero
	add $a1, $s1, $zero
	addi $sp, $sp, 0xFFFFFFFC
	sw $ra, 0($sp)
	jal rick
	lw $ra, 0($sp)
	addi $sp, $sp, 0x4
	j loopcont
	
else:	
	add $v0, $zero, $zero

loopcont:	
	add $a0, $v0, $zero
	addi $v0, $zero, 0x1
	syscall
	la $a0, print
	addi $v0, $zero, 0x4
	syscall
	addi $s2, $s2, 0x1
	j loop

exit:
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
        lw $s0, 0($sp)
        addi $sp, $sp, 0x10
	addi $v0, $zero, 0xA
	syscall
	
