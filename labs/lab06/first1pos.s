	.data
labelshift:
	.asciiz "first1posshift:\n"
labelmask:
	.asciiz "first1posmask:\n"
args:	
	.word labelshift first1posshift labelmask first1posmask
tin:	
	.word 0x80000000 0x00010000 0x0000000001 0x00000000 # place tests here
	# expect 31, 16, 0, -1
	.text
main:
	li	$s1,4 # number of tests to do
	sll	$s1,$s1,2
	or	$s2,$0,$0
	li	$s3,9
mainouterloop:
	la	$t0,args
	add	$t0,$t0,$s2
	lw	$a0,0($t0)
	lw	$a1,4($t0)
	li	$v0,4
	syscall
	or 	$s0,$0,$0
maininnerloop:	
	la	$t0,tin
	add	$t0,$t0,$s0
	lw	$a0,0($t0)
	jalr	$a1
	jal	printv0
	addi	$s0,$s0,4
	blt	$s0,$s1,maininnerloop
	addi	$s2,$s2,8
	blt	$s2,$s3,mainouterloop
	li	$v0,10
	syscall


first1posshift:
	# YOUR CODE HE

	
	beqz 	$a0 return1
	move 	$t2 $a0
	li 	$t5 31
	j	helper1
return1: 
	addi    $v0 $zero -1
	jr	$ra
helper1:
	bltz	$t2 return_pos
	j 	else
return_pos:	
	move $v0 $t5
	jr $ra
else:	
	sll $t2 $t2 1
	addi $t5  $t5 -1
	bltz $t2 return_pos
	j else
	
	

first1posmask:
	# YOUR CODE HER
	beqz 	$a0 return2
	li $t7 0x80000000 # mask
	li $t2 31 # index
	and $t1 $a0 $t7 #  do mask
	beqz $t1 helper2
	j return_pos2
return2: 
	addi    $v0 $zero -1
	jr	$ra
helper2:
	srl $t7, $t7, 1
	addi $t2 $t2 -1
	and $t1 $a0 $t7 #  do mask
	beqz $t1 helper2
	j return_pos2
return_pos2:	
	move $v0 $t2
	jr $ra



printv0:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	add	$a0,$v0,$0
	li	$v0,1
	syscall
	li	$v0,11
	li	$a0,'\n'
	syscall
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	jr	$ra
