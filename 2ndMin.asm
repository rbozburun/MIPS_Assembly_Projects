.data
noSecondElem: .asciiz "There is no second smallest"
arr: .word  13,16,16,7,7
size: .word 5

.text
addi $s0 $zero 1 # index for array
addi $s1 $zero 0 # first min value
addi $s2 $zero 999999999 # second min value

lw $t0 size # size
la $t1 arr # adress of arr
lw $t2 0($t1) # first element of array

addi $s1 $t2 0 # first min = arr[0]

addi $t3 $zero 0 # current element of array 
addi $t1 $t1 4 # next value in arr --> arr[1]

LOOP: beq $s0 $t0 EXIT # check elements for each index 
lw $t3 0($t1) # set current element for current index
slt $t7 $t3 $s1 # if current element is smaller then first min then t7 is 1 if not, it will return 0
beq $t7 $zero CHECKSECOND # if t7 zero, this means first min is first min. Current element cannot be first min. But need to checks second element.
addi $s2 $s1 0 # set second to first min
addi $s1 $t3 0 # set first to current element of array

beq $s1 $t3 CONTINUE # if first min equal to current element then continue to loop
CHECKSECOND: 
beq $s1 $t3 CONTINUE # if first min equal to current element then continue to loop
slt $t7 $t3 $s2 # if t3 < s2 --> return 1 else 0 (check current element is smaller then second min?)
beq $t7 $zero CONTINUE # if t7 is zero then continue the loop, else assign second min to current element
addi $s2 $t3 0 
CONTINUE:
addi $t1 $t1 4 # Get the next element in array
addi $s0 $s0 1 # index++;
j LOOP 
EXIT:

beq $s2 999999999 RETURN # if t2 is equal to it's initial value, this means there is no any second element. So that, return noSecondElem. Else, print integer value
li $v0 1 
addi $a0 $s2 0
syscall
j TERMINATE
RETURN: 
li $v0 4 # print noSecondElem
la $a0 noSecondElem 
syscall
TERMINATE:
