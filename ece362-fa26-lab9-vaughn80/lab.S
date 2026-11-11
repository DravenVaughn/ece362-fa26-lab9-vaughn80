######################################################
# Lab 9 template file
######################################################

######################################################
# .data is where variables will reside.
# We define the following below so you know what 
# their values are.
.data
.global lowercase_string
lowercase_string:
    // Specify a string ending with '\0'
    .asciz "ece 362 is awesome!"

// Align to 4bytes boundary as we have a string above
.balign 4
######################################################


######################################################
# All code goes in the .text section
.text

.global asm_strlen
asm_strlen:
    /* uint32_t asm_strlen(char *str)
     * Take in a pointer to a string and return
     * its length up to the null terminating
     * character `\0`
    **/   

    /* Enter your code after this comment */
    beq     a0, x0, 1f          

    mv      t0, a0              
    li      a1, 0               

2:  lbu     t1, 0(t0)           
    beq     t1, x0, 3f          
    addi    a1, a1, 1           
    addi    t0, t0, 1           
    j       2b                  

3:  mv      a0, a1              
    ret

1:  li      a0, 0               
    ret
    /* Enter your code above this comment */
    ret

.global asm_fib
asm_fib:
    /* void asm_fib(int *arr, uint32_t length)
     * Accept a pointer to an array of integer and
     * the length of the array, then generate fibonacci
     * series starting at `0` and store the result
     * back to the array `arr` at corresponding indices.
     **/

    /* Enter your code after this comment */
    beq     a0, x0, .L_fib_done
    beq     a1, x0, .L_fib_done

    # Initialize variables
    li      t1, 0           
    li      t2, 0           
    li      t3, 1           
    li      t4, 4          

.L_fib_loop:
    bge     t1, a1, .L_fib_done

    mul     t5, t1, t4     
    add     t6, a0, t5      

    li      t0, 0
    beq     t1, t0, .L_fib_store_prev   

    li      t0, 1
    beq     t1, t0, .L_fib_store_curr   

    mv      t0, t3          # t0 = tmp 
    add     t3, t3, t2      # curr = curr + prev
    mv      t2, t0          # prev = tmp
    sw      t3, 0(t6)       # arr[i] = curr
    j       .L_fib_next

.L_fib_store_prev:
    sw      t2, 0(t6)       # arr[0] = prev
    j       .L_fib_next

.L_fib_store_curr:
    sw      t3, 0(t6)       # arr[1] = curr 

.L_fib_next:
    addi    t1, t1, 1       # i++
    j       .L_fib_loop

.L_fib_done:
    ret
    /* Enter your code above this comment */
    ret

.global asm_toUppercase
asm_toUppercase:
    /* void asm_toUppercase(char *str)
     * loop through an entire string and only convert
     * the lowercase letter to uppercase, leaving the
     * rest of the string intact
     **/

    /* Enter your code after this comment */
    beq     a0, x0, .L_upper_done

    mv      t0, a0          
    li      t2, 97          
    li      t3, 122        

.L_upper_loop:
    lbu     t1, 0(t0)       # Load current character byte
    beq     t1, x0, .L_upper_done # If character is '\0'

    
    blt     t1, t2, .L_upper_next
    blt     t3, t1, .L_upper_next

    addi    t1, t1, -32
    sb      t1, 0(t0)     

.L_upper_next:
    addi    t0, t0, 1      
    j       .L_upper_loop

.L_upper_done:
    ret
    /* Enter your code above this comment */
    ret


######################################################