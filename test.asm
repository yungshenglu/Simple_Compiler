section .data
numbers db "0123456789", 0xA
inputchar db 0
section .text
global F_124565444
F_124565444:
push	ebp
move	ebp, esp
sub esp, 4
mov dword [ebp-4], 0
jmp G2
G1:
add dword [ebp-4], 1
push edx
G2:
mov edx, 0
mov eax, [ebp+8]
mov ebx, 10
div ebx
mov [ebp+8], eax
cmp eax, 0
jnz G1
push edx
add dword [ebp-4], 1
jmp G3
G4:
sub dword [ebp-4], 1
pop edx
mov eax, 4
mov ebx, 1
mov ecx, numbers
add ecx, edx
mov edx, 1
int 80h
G3:
cmp dword [ebp-4], 0
jnz G4
mov eax, 4
mov ebx, 1
lea ecx, [numbers+10]
mov edx, 1
int 80h
leave
jr
global F_7362500
F_7362500:
push	ebp
move	ebp, esp
sub esp, 4
mov dword [ebp-4], 0
mov byte [inputchar], 0
jmp G6
G5:
mov dword eax, [ebp-4]
mov ebx, 10
mul ebx
xor ecx, ecx
mov byte cl, [inputchar]
sub ecx, 48
add eax, ecx
mov dword [ebp-4], eax
G6:
mov eax, 03h
mov ebx, 00h
mov ecx, inputchar
mov edx, 01h
int 80h
cmp byte [inputchar], 0ah
jne G5
mov dword eax, [ebp-4]
leave
jr
global F_206329998
F_206329998:
push	ebp
move	ebp, esp
sub	esp, 4
push	dword [ebp+12]
push	dword [ebp+8]
pop	ebx
pop	eax
lea	eax, [eax+ebx]
push	dword eax
lea	ebx, [ebp-4]
pop	eax
move	dword [ebx], eax
push	dword [ebp-4]
pop	eax
leave
jr
leave
jr
global F_116996094
F_116996094:
push	ebp
move	ebp, esp
sub	esp, 4
sub	esp, 4
sub	esp, 4
sub	esp, 4
sub	esp, 40
push	dword [ebp-4]
push	dword [ebp-8]
pop	ebx
pop	eax
lea	eax, [eax+ebx]
push	dword eax
push	dword [ebp-8]
pop	ebx
pop	eax
mult	eax, ebx
push	dword eax
lea	ebx, [ebp-12]
pop	eax
move	dword [ebx], eax
push	dword [ebp-4]
push	dword [ebp-8]
pop	ebx
pop	eax
lea	eax, [eax+ebx]
push	dword eax
push	dword [ebp-4]
push	dword [ebp-8]
pop	ebx
pop	eax
mult	eax, ebx
push	dword eax
push	dword 1
pop	ebx
pop	eax
move	edx, eax
sar	edx, 31
div	ebx
push	dword eax
pop	ebx
pop	eax
sub	eax, ebx
push	dword eax
lea	ebx, [ebp-12]
pop	eax
move	dword [ebx], eax
push	dword [ebp-4]
push	dword [ebp-8]
pop	ebx
pop	eax
cmp	eax, ebx
setg	al
movzx	eax, al
push	dword eax
pop	eax
cmp	eax, 0
beq	L1
push	dword [ebp-4]
push	dword [ebp-8]
pop	ebx
pop	eax
sub	eax, ebx
push	dword eax
lea	ebx, [ebp-12]
pop	eax
move	dword [ebx], eax
j	L2
L1:
push	dword [ebp-8]
push	dword [ebp-4]
pop	ebx
pop	eax
sub	eax, ebx
push	dword eax
lea	ebx, [ebp-12]
pop	eax
move	dword [ebx], eax
L2:
push	dword 10
lea	ebx, [ebp-16]
pop	eax
move	dword [ebx], eax
j	L3
L4:
push	dword [ebp-16]
push	dword 1
pop	ebx
pop	eax
sub	eax, ebx
push	dword eax
lea	ebx, [ebp-16]
pop	eax
move	dword [ebx], eax
L3:
push	dword [ebp-16]
push	dword 0
pop	ebx
pop	eax
cmp	eax, ebx
setg	al
movzx	eax, al
push	dword eax
pop	eax
cmp	eax, 1
beq	L4
push	dword 5
push	dword 1
pop	eax
move	ebx, ebp
mult	eax, 4
add	ebx, eax
sub	ebx, 56
pop	eax
move	dword [ebx], eax
push	dword 10
push	dword 6
pop	eax
move	ebx, ebp
mult	eax, 4
add	ebx, eax
sub	ebx, 56
pop	eax
move	dword [ebx], eax
push	dword 1
pop	eax
move	ebx, ebp
mult	eax, 4
add	ebx, eax
sub	ebx, 56
push	dword [ebx]
push	dword 6
pop	eax
move	ebx, ebp
mult	eax, 4
add	ebx, eax
sub	ebx, 56
push	dword [ebx]
pop	ebx
pop	eax
lea	eax, [eax+ebx]
push	dword eax
lea	ebx, [ebp-12]
pop	eax
move	dword [ebx], eax
push	dword [ebp-4]
push	dword [ebp-8]
jal	F_206329998
add	esp, 8
push	dword eax
lea	ebx, [ebp-12]
pop	eax
move	dword [ebx], eax
push	dword 0
pop	eax
leave
jr
leave
jr
