section .data
numbers db "0123456789", 0xA
inputchar db 0
section .text
global F_124565444
F_124565444:
addi	$sp, $sp, -4
sw	$fp, 0($sp)
move	$fp, $sp
addi $sp, -4
move -4($fp), 0
j G2
G1:
add -4($fp), 1
addi $sp, $sp, -4
sw $t3, 0($sp)
G2:
move	$t3, 0
move $t0, 8($fp)
move $t1, 10
div $t1
move 8($fp), $t0
cmp $t0, 0
jnz G1
addi $sp, $sp, -4
sw $t3, 0($sp)
add -4($fp), 1
j G3
G4:
sub -4($fp), 1
lw $t3, 0($sp)
addi $sp, $sp, 4
move $t0, 4
move $t1, 1
move $t2, numbers
add $t2, $t3
move $t3, 1
int 80h
G3:
cmp -4($fp), 0
jnz G4
move $t0, 4
move $t1, 1
lea $t2, 10(numbers)
move $t3, 1
int 80h
move	$sp, $fp
lw	$fp, 0($sp)
addi	$sp, $sp, 4
jr
global F_7362500
F_7362500:
addi	$sp, $sp, -4
sw	$fp, 0($sp)
move	$fp, $sp
addi $sp, -4
move -4($fp), 0
move byte [inputchar], 0
j G6
G5:
move $t0, -4($fp)
move $t1, 10
mult $t1
xor $t2, $t2
move byte cl, [inputchar]
addi $t2, -48
add $t0, $t2
move -4($fp), $t0
G6:
move $t0, 03h
move $t1, 00h
move $t2, inputchar
move $t3, 01h
int 80h
cmp byte [inputchar], 0ah
jne G5
move $t0, -4($fp)
move	$sp, $fp
lw	$fp, 0($sp)
addi	$sp, $sp, 4
jr
global F_206329998
F_206329998:
addi	$sp, $sp, -4
sw	$fp, 0($sp)
move	$fp, $sp
addi	$sp, $sp, -4
addi	$sp, $sp, -4
sw	12($fp), 0($sp)
addi	$sp, $sp, -4
sw	8($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
lea	$t0, $t1($t0)
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -4($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	$sp, $fp
lw	$fp, 0($sp)
addi	$sp, $sp, 4
jr
move	$sp, $fp
lw	$fp, 0($sp)
addi	$sp, $sp, 4
jr
global F_116996094
F_116996094:
addi	$sp, $sp, -4
sw	$fp, 0($sp)
move	$fp, $sp
addi	$sp, $sp, -4
addi	$sp, $sp, -4
addi	$sp, $sp, -4
addi	$sp, $sp, -4
addi	$sp, $sp, -40
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
lea	$t0, $t1($t0)
addi	$sp, $sp, -4
sw	$t0, 0($sp)
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
mult	$t0, $t1
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -12($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
lea	$t0, $t1($t0)
addi	$sp, $sp, -4
sw	$t0, 0($sp)
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
mult	$t0, $t1
addi	$sp, $sp, -4
sw	$t0, 0($sp)
addi	$sp, $sp, -4
sw	1, 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	$t3, $t0
sar	$t3, 31
div	$t6, $t1
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
sub	$t0, $t1
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -12($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
addi	$t9, $t9, 1
slt	$t8, $t1, $t0
beq	$t8, $t9, GT
GT:
move	$t4, $t9
movzx	$t0, $t4
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
addi	$t8, $t8, 0
beq	$t0, $t8, L1
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
sub	$t0, $t1
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -12($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
j	L2
L1:
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
sub	$t0, $t1
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -12($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
L2:
addi	$sp, $sp, -4
sw	10, 0($sp)
lea	$t1, -16($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
j	L3
L4:
addi	$sp, $sp, -4
sw	-16($fp), 0($sp)
addi	$sp, $sp, -4
sw	1, 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
sub	$t0, $t1
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -16($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
L3:
addi	$sp, $sp, -4
sw	-16($fp), 0($sp)
addi	$sp, $sp, -4
sw	0, 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
addi	$t9, $t9, 1
slt	$t8, $t1, $t0
beq	$t8, $t9, GT
GT:
move	$t4, $t9
movzx	$t0, $t4
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
addi	$t8, $t8, 1
beq	$t0, $t8, L4
addi	$sp, $sp, -4
sw	5, 0($sp)
addi	$sp, $sp, -4
sw	1, 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	$t1, $fp
addi	$t7, $t7, 4
mult	$t0, $t7
add	$t1, $t1, $t0
addi	$t1, $t1, -56
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
addi	$sp, $sp, -4
sw	10, 0($sp)
addi	$sp, $sp, -4
sw	6, 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	$t1, $fp
addi	$t7, $t7, 4
mult	$t0, $t7
add	$t1, $t1, $t0
addi	$t1, $t1, -56
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
addi	$sp, $sp, -4
sw	1, 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	$t1, $fp
addi	$t7, $t7, 4
mult	$t0, $t7
add	$t1, $t1, $t0
addi	$t1, $t1, -56
addi	$sp, $sp, -4
sw	0($t1), 0($sp)
addi	$sp, $sp, -4
sw	6, 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	$t1, $fp
addi	$t7, $t7, 4
mult	$t0, $t7
add	$t1, $t1, $t0
addi	$t1, $t1, -56
addi	$sp, $sp, -4
sw	0($t1), 0($sp)
lw	$t1, 0($sp)
addi	$sp, $sp, 4
lw	$t0, 0($sp)
addi	$sp, $sp, 4
lea	$t0, $t1($t0)
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -12($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
addi	$sp, $sp, -4
sw	-4($fp), 0($sp)
addi	$sp, $sp, -4
sw	-8($fp), 0($sp)
jal	F_206329998
addi	$sp, $sp, 8
addi	$sp, $sp, -4
sw	$t0, 0($sp)
lea	$t1, -12($fp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	 0($t1), $t0
addi	$sp, $sp, -4
sw	0, 0($sp)
lw	$t0, 0($sp)
addi	$sp, $sp, 4
move	$sp, $fp
lw	$fp, 0($sp)
addi	$sp, $sp, 4
jr
move	$sp, $fp
lw	$fp, 0($sp)
addi	$sp, $sp, 4
jr
