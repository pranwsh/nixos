.section .data
num1: .long 5
num2: .long 7

.section .text
.globl _start

_start:
    movl num1, %eax     # eax = num1
    addl num2, %eax     # eax = eax + num2

    # exit(0)
    movl $1, %eax       # sys_exit
    xorl %ebx, %ebx
    int $0x80




