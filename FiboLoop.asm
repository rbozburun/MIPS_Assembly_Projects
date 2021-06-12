.data
	prompt: .asciiz "Enter the sequence number: "
	strFib0: .asciiz "F(0)= 0"
	strFib1: .asciiz "F(1)= 1"
	strFib2: .asciiz "F(2)= 1"
	strFibF: .asciiz "F("
	strFibA: .asciiz ")= "

.text
	main:
		li $v0 4 #Service to print string
		la $a0 prompt   #Load adress of prompt to print service
		syscall #print

		#Get input from user
		li $v0 5 #Service to read int
		syscall
		move $t0 $v0 #Store the result in $t0

		add $s5 $t0 $zero #Save t0's initial value

		beq $t0 0 fib0 # If given value 0 -> fib(0)
		beq $t0 1 fib1 # If given value 0 -> fib(1)
		beq $t0 2 fib2 # If given value 0 -> fib(2)

		addi $a2 $zero 3  #a2 = 3

		addi $s1 $zero 1 #1. element of fib seq (x)
		addi $s2 $zero 1 #2. element of fib seq (x+1) / for 2. element 1 is exception
		add $s3 $s1 $s2 # x + x+1

		LOOP: 
			slt $a1 $a2 $t0# 3<t0 
			beq $a1 $zero BREAK
			add $s1 $s2 $zero #first moves next
			add $s2 $s3 $zero #Second moves next
			add $s3 $s1 $s2 #Get next element of fibonacci se
			add $t0 $t0 -1 # t0 = t0-1
			j LOOP

		BREAK:
			li $v0 4 #print str
			la $a0 strFibF
			syscall
			
			li $v0 1 #print int
			la $a0 ($s5)
			syscall
			
			li $v0 4 #print str
			la $a0 strFibA
			syscall
			
			li $v0 1 #print int
			la $a0 ($s3)
			syscall
			#Terminate program
			li $v0 10
			syscall 

	fib0:
		li $v0 4 #Service to print string
		la  $a0 strFib0   #Load 0 to print service
		syscall #print
		
		#Terminate program
		li $v0 10
		syscall

	fib1:
		li $v0 4 #Service to print string
		la  $a0 strFib1   #Load 0 to print service
		syscall #print
		
		#Terminate program
		li $v0 10
		syscall

		fib2:
		li $v0 4 #Service to print string
		la  $a0 strFib2   #Load 0 to print service
		syscall #print
