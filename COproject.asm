.data
# BFS representation of the binary tree
bfs: .word 1, 2, 3, 4, 5, 6, 7
length: .word 7

# Array to store the DFS output
dfs: .space 28
# Index to keep track of position in DFS array
dfs_index: .word 0

# String to print
message: .asciiz "done CO project el7amdolilah"

.text
.globl main

main:
    la   $a0, bfs       # Load address of bfs array into $a0
    la   $a1, dfs       # Load address of dfs array into $a1
    lw   $a2, length    # Load length of the bfs array into $a2
    li   $a3, 0         # Start with the root node index (0)
    li   $s0, 0         # Initialize dfs_index to 0

    jal  dfs_convert

    # Print the dfs array
    move $t0, $v0        # Load address of dfs array into $t0
    lw   $t1, length    # Load length of the dfs array into $t1
    li   $t2, 0         # Initialize index to 0

print_loop:
    bge  $t2, $t1, exit_print_loop  # Exit loop if index >= length
    sll  $t3, $t2, 2    # index * 4 (size of word)
    add  $t4, $t0, $t3  # Calculate address of dfs[index]
    lw   $a0, 0($t4)    # Load value from dfs[index]
    #move $a0, $v0
    li   $v0, 1         # Print integer syscall
    syscall

    #Print newline
    li   $v0, 11        # Print character syscall
    li   $a0, 10        # ASCII code for newline
    syscall

    addi $t2, $t2, 1    # Increment index
    j    print_loop     # Jump back to the start of the loop

exit_print_loop:
	li $v0, 11
	li $a0, 10
	syscall
    # Print "done الحمدلله"
    la   $a0, message   # Load address of message into $a0
    li   $v0, 4         # Print string syscall
    syscall

    li   $v0, 10        # Exit program syscall
    syscall

dfs_convert:
    move $v0, $a1
    bge  $a3, $a2, exit_for_dfs_convert  # base case for the recursion

    addi $sp, $sp, -12  # Save space for 4 registers
    sw   $ra, 0($sp)    # Save return address
    sw   $a3, 4($sp)    # Save index of the bfs array
    sw   $a2, 8($sp)   # Save length of the bfs array

    sll  $t3, $a3, 2    # index * 4
    add  $t1, $a0, $t3  # Calculate the load address of the bfs array
    add  $t2, $a1, $s0  # Calculate the store address of the dfs array

    lw   $t0, 0($t1)    # Load value from the bfs array
    sw   $t0, 0($t2)    # Store value into the dfs array

    addi $s0, $s0, 4    # Increment the index of the dfs array


    # Left child index
    sll  $t4, $a3, 1    # Left child index = 2 * index + 1
    addi $t4, $t4, 1    # Calculate left child index
    move $a3, $t4       # Update $a3 to left child index
    jal  dfs_convert    # Recursive call to the left child

    lw $a3, 4($sp)
    # Right child index
    sll  $t5, $a3, 1    # Right child index = 2 * index + 2
    addi $t5, $t5, 2    # Calculate right child index
    move $a3, $t5       # Update $a3 to right child index
    jal  dfs_convert    # Recursive call to the right child

    j exit_for_dfs_convert
restore_and_return:
    lw   $ra, 0($sp)    # Restore return address
    lw   $a3, 4($sp)    # Restore index of the bfs array
    lw   $a2, 8($sp)   # Restore length of the bfs array
    addi $sp, $sp, 12   # Restore stack pointer
    jr   $ra            # Return to the caller

exit_for_dfs_convert:
    j restore_and_return # Jump to restore and return section


bfs_convert:
    move $v0, $a0
    bge  $a3, $a2, exit_for_bfs_convert  # base case for the recursion

    addi $sp, $sp, -12  # Save space for 4 registers
    sw   $ra, 0($sp)    # Save return address
    sw   $a3, 4($sp)    # Save index of the bfs array
    sw   $a2, 8($sp)   # Save length of the bfs array

    sll  $t3, $a3, 2    # index * 4
    add  $t1, $a0, $t3  # Calculate the load address of the bfs array
    add  $t2, $a1, $s0  # Calculate the store address of the dfs array

    lw   $t0, 0($t2)    # Load value from the bfs array
    sw   $t0, 0($t1)    # Store value into the dfs array

    addi $s0, $s0, 4    # Increment the index of the dfs array


    # Left child index
    sll  $t4, $a3, 1    # Left child index = 2 * index + 1
    addi $t4, $t4, 1    # Calculate left child index
    move $a3, $t4       # Update $a3 to left child index
    jal  bfs_convert    # Recursive call to the left child

    lw $a3, 4($sp)
    # Right child index
    sll  $t5, $a3, 1    # Right child index = 2 * index + 2
    addi $t5, $t5, 2    # Calculate right child index
    move $a3, $t5       # Update $a3 to right child index
    jal  bfs_convert    # Recursive call to the right child

    j exit_for_bfs_convert
restore_and_return2:
    lw   $ra, 0($sp)    # Restore return address
    lw   $a3, 4($sp)    # Restore index of the bfs array
    lw   $a2, 8($sp)   # Restore length of the bfs array
    addi $sp, $sp, 12   # Restore stack pointer
    jr   $ra            # Return to the caller

exit_for_bfs_convert:
    j restore_and_return2 # Jump to restore and return section

# Assume the number whose log base 2 you want to calculate is in register $t0
# and the target is in $a1
first_search:
	li $t0, 0
	j search_loop
search_loop:
	bge $t0, $a2, exit_loop
	
	sll $t3, $t0, 2
	add $t3, $t3, $a0
	
	lw $t4, 0($t3)
	beq $t4, $a1, log_base_2 #assume that the target is in a1
	
	addi $t0, $t0, 1
	j search_loop
	
	
	
exit_loop:
	li $v0, -1
	jr $ra
log_base_2:
	beq $t0, $zero, zero_case
    # Initialize counter to -1
    addi $t0, $t0, 1
    li   $v0, -1

count_bits_loop:
    # Shift the number right by 1 bit
    srl  $t0, $t0, 1

    # Increment the counter
    addi $v0, $v0, 1

    # Check if the number is zero (all bits shifted out)
    bne  $t0, $zero, count_bits_loop

    # $t1 now contains the number of bits required to represent the original number
    # Subtract 1 to get the log base 2
    addi $v0, $v0, 0

    # The result is in $t1
    # You can use $t1 here or store it in another register or memory location

    # End of the log_base_2 function
    jr   $ra
 zero_case:
 	li $v0, 0
 	jr $ra
 	
 second_search:
 	addi $sp, $sp, 4
 	sw $ra, 0($sp)
 	jal bfs_convert
 	li $a1, 15 #load here the target
 	#li $t3, 0
 	#li $t4, 0
 	
 	jal first_search
 	
 	lw $ra, 0($sp)
 	jr $ra