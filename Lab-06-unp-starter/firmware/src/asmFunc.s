/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Javier Ayala"  
 
.align    /* ensure following vars are allocated on word-aligned addresses */

/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global a_value,b_value
.type a_value,%gnu_unique_object
.type b_value,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
a_value:          .word     0  
b_value:           .word     0  

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    //this copies r0 into r4 because we need to extract and process the upper 16 bits
    mov r4, r0
    //this shifts right to move the upper 16 bits into the lower half while keeping the sign intact
    asr r4, r4, #16
    //this copies r0, but this time it's so that we can extract and process the lower 16 bits seprately from the upper
    mov r5, r0
    //this makes all the numbers shift left to remove the upper 16 bits so that they won't interfere with whatever value we want
    lsl r5, r5, #16
    //this makes all the numbers shift right to restore the sign of the lower 16 bits
    asr r5, r5, #16
    
    //this will load the memory address of the a_value variable into r6 because this is where the upper 16 bit value will be stored
    ldr r6, =a_value
    //this stores the value r4 into memory location pointed to by r6 because r6 has the address of a_value, which will write the result into a_value
    str r4, [r6]
    //this will load the memory address of b_value into r6 because b_value is where the lower q6 bit value will be stored 
    ldr r6, =b_value
    //this stores the value inside r5 into the memoery location pointed to by r6 because r6 has the address of b_value
    str r5, [r6]
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




