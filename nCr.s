.globl nCr
	.type	nCr, @function
nCr:
  # Your code for nCr should go here

	pushl	%ebp			#Pushes the base pointer on the stack
	movl	%esp, %ebp		#Moves the stack pointer to %ebp
	subl	$40, %esp		#Makes room for the function
	movl	12(%ebp), %eax		#puts the second parameter r into %eax
	movl	8(%ebp), %edx		#puts the first parameter n into %edx
	subl	%eax, %edx		#subtracts r from n and saves it in %edx	
	cmpl	%eax, %edx		#compares r to n-r
	cmovge	%edx, %eax		#moves %edx into %eax if %edx is greater or equal
	movl	%eax, -24(%ebp)		#moves %eax to a variable greatest
	movl	$1, -20(%ebp)		#moves 1 to another variable later used in a loop
	movl	12(%ebp), %eax		#moves r back into %eax
	movl	8(%ebp), %edx		#moves n back into %edx
	subl	%eax, %edx		#finds n-r again, putting it in %edx		
	cmpl	%eax, %edx		#compares r to n-r
	cmovle	%edx, %eax		#moves %edx into %eax if %edx is less than or equal
	movl	%eax, -16(%ebp)		#moves %eax to a varible least
	movl	8(%ebp), %eax		#moves n into -12(%ebp)  	
	movl	%eax, -12(%ebp)		#tried to get rid of this by making the above line leal but kept getting error
	jmp	.L7
.L8:	
	movl	-20(%ebp), %eax		#moves the loop variable into %eax
	imull	-12(%ebp), %eax		#multiplies n by the loop varible
	jo	.L9			#if overflow is detected jumps to .L9
	movl	%eax, -20(%ebp)		#sets the loop variable to the product
	subl	$1, -12(%ebp)		#n= n-1
.L7:
	movl	-12(%ebp), %eax		#moves n into %eax
	cmpl	-24(%ebp), %eax		#compares greatest to n
	jg	.L8			#if n is greater jumps up to .L8 to start a loop 
	movl	-16(%ebp), %eax		#moves the least variable to %eax
	movl	%eax, (%esp)		#moves least to the front of the stack
	call	Factorial		#calls Factorial on least
	movl	%eax, -16(%ebp)		#moves the result into least which now becomes the divisor
	movl	-20(%ebp), %eax		#moves the product into %eax
	movl	%eax, %edx		#moves the product into %edx
	sarl	$31, %edx		#arithmetic shift right on %edx by 31 to begin the divison process
	idivl	-16(%ebp)		#%eax =product/divisor
	jmp	.L10
.L9:
	movl	$0, %eax		#If overflow %eax is set to 0
.L10:
	leave				#clean up
	ret				#returns %eax
	.size	nCr, .-nCr

.globl Factorial
	.type	Factorial, @function
Factorial:
  # Your code for Factorial should go here
	pushl	%ebp			#pushes %ebp to the top of the stack
	movl	%esp, %ebp		#moves %esp to %ebp
	subl	$24, %esp		#makes space for the function
	cmpl	$1, 8(%ebp)		#compares the first parameter n to 1
	jg	.L2			#if n is greater than one goes to .L2
	movl	$1, %eax		#if n is 0 or 1, (Since the formula.c makes sure the number can't be negative), sets %eax to 1 
	jmp	.L3			#jumps to return
.L2:
	movl	8(%ebp), %eax		#moves n to %eax
	subl	$1, %eax		#n=n-1
	movl	%eax, (%esp)		#moves %eax to the top of the stack
	call	Factorial		#Calls Factorial on n
	imull	8(%ebp), %eax		#multiplies n by the result of Factorial n
.L3:
	leave				#clean up
	ret				#returns the factorial of n
	.size	Factorial, .-Factorial
