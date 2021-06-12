.data
	prompt: .asciiz "Enter the sequence number: "
	strFib2: .asciiz "F(2)= 1"
	strFibF: .asciiz "F("
	strFibA: .asciiz ")= "
	theNumber: .word 0
	theAnswer: .word 0

.text
	main:
	li $v0 4 #Service to print string
	la $a0 prompt   #Load adress of prompt to print service
	syscall #print

	#Get input from user
	li $v0 5 #Service to read int
	syscall
	sw $v0 theNumber #Store given number in theNumber (Initial)
	move $t0 $v0 #Store given number in t0 to decrease for each call
	addi $t1 $zero 1 #base case 
	
	#Call the fib function
	lw $a0, theNumber
	jal fib
	sw $v0 theAnswer #Load the answer to v0 to return
	
	li $v0 4 #print str -> F=(
	la $a0 strFibF
	syscall
	
	li $v0 1 #print int -> N
	lw $a0 theNumber
	syscall
	
	li $v0 4 #print str -> )= 
	la $a0 strFibA
	syscall
	
	li $v0 1 #print int
	lw $a0 theAnswer
	syscall
	
	#Terminate program
	li $v0 10
	syscall 

fib:
	slt $t2 $t1 $a0 #t2 = 1 -> a0 > 1
	beq $t2 $t1 CALL_REC
	add $v0 $zero $a0
	jr $ra
	
CALL_REC:
	#Push stack
	addi $sp $sp -12 #Stack holds 2 element 0 - 4 - 8
	sw $ra 0($sp) #Store value of return adress in 0
	sw $a0 4($sp) #Store the value of local variable in stack (4)
	
	addi $a0 $a0 -1 #to get fib(n-1)
	jal fib #Call for fib(n-1)
	sw $v0 8($sp) #Store value of fib(n-1) on stack (8)
	
	lw $a0 4($sp)
	addi $a0 $a0 -2 #to get fib(n-2)
	jal fib 
	
	#Pop stack - if base case occurs, stack will pop
	lw $t0 8($sp)
	add $v0 $v0 $t0
	lw $ra 0($sp)
	addi $sp $sp 12
	jr $ra
