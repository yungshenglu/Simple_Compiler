#include <stdio.h>
#include <string.h>
#include <math.h>

#include "command.h"
#include "hash.h"

void output(char *str) {
	printf("%s\n", str);
}

static int func_is_main(int funcname) {
	if (funcname == ELFHash("idMain", 4))
		return 1;

	return 0;
}

static void getvarstr(char *varstr, int offset) {
	if (offset >= 0)
		sprintf(varstr, "%d(%s)", offset, FP);
	else
		sprintf(varstr, "%d(%s)", offset, FP );
}

static int getregstr(char *regstr, int reg) {
	switch (reg) {
		case 1:
			strcpy(regstr, T0);
			return 0;
		case 2:
			strcpy(regstr, T1);
			return 0;
		case 3:
			strcpy(regstr, T2);
			return 0;
		case 4:
			strcpy(regstr, T3);
			return 0;
	}

	return -1;
}

int creat_label() {
	static int labelno = 0;
	return ++labelno;
}

void code_label(int labelno) {
	sprintf(strbucket, "%s%d:", LABEL, labelno);
	output(strbucket);
}

/* Jump instruction */
void code_jmp(int labelno) {
	sprintf(strbucket, "%s\t%s%d", J, LABEL, labelno);
	output(strbucket);
}

void code_pop(int reg) {
	char regstr[REGSTR_LENGTH];
	getregstr(regstr, reg);

	sprintf(strbucket, "%s\t%s, 0(%s)", LW, regstr, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s, 4", ADDI, SP, SP);
	output(strbucket);
}

void code_lea_global(int target, int addr, int offset) {
	char offreg[REGSTR_LENGTH];
	char tarreg[REGSTR_LENGTH];

	int array = getregstr(offreg, offset);
	getregstr(tarreg, target);

	if (array == -1) {	/* not array */
		sprintf(strbucket, "%s\t%s, 0(%d)", LEA, tarreg, addr);
	}
	else {				/* array with offset */
		sprintf(strbucket, "%s\t%s, %s(%d)", LEA, tarreg, offreg, addr);
	}

	output(strbucket);
}

void code_lea_local(int target, int var) {
	char t_reg[REGSTR_LENGTH];
	char s_var[VARSTR_LENGTH];

	getregstr(t_reg, target);
	getvarstr(s_var, var);

	sprintf(strbucket, "%s\t%s, %s", LEA, t_reg, s_var);
	output(strbucket);
}

void code_move_reg(int target, int source) {
	char t_reg[REGSTR_LENGTH];
	char s_reg[REGSTR_LENGTH];

	if (target == source)
		return;

	getregstr(t_reg, target);
	getregstr(s_reg, source);

	sprintf(strbucket, "%s\t%s, %s", MOVE, t_reg, s_reg);
	output(strbucket);
}

void code_push_mem(int addr, int offset) {
	char regstr[REGSTR_LENGTH];
	getregstr(regstr, offset);

	sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s(%d), 0(%s)", SW, regstr, addr, SP);
	output(strbucket);
}

void code_push_reg(int reg, int mem) {
	char regstr[REGSTR_LENGTH];
	getregstr(regstr, reg);

	if (mem) {
		sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
		output(strbucket);

		sprintf(strbucket, "%s\t0(%s), 0(%s)", SW, regstr, SP);
	}
	else {
		sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
		output(strbucket);

		sprintf(strbucket, "%s\t%s, 0(%s)", SW, regstr, SP);
	}

	output(strbucket);
}

void code_push_ind(int idx) {
	char varstr[VARSTR_LENGTH];
	getvarstr(varstr, idx);

	sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, 0(%s)", SW, varstr, SP);
	output(strbucket);
}

void code_push_cons(int constant) {
	sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%d, 0(%s)", SW, constant, SP);
	output(strbucket);
}

void code_push_global_var(int var, int offset) {
	if (offset >= 0) {
		sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
		output(strbucket);

		sprintf(strbucket, "%s\t%d(%d), %s", SW, offset, var, SP);
	}
	else {
		sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
		output(strbucket);

		sprintf(strbucket, "%s\t%d(%d), %s", SW, offset, var, SP);
	}
	
	output(strbucket);
}

void code_push_global_array(int var) {
	sprintf(strbucket, "%s\t%s, %s, %d", ADDI, T5, ZR, var);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, 0(%s)", SW, T5, SP);
	output(strbucket);
}

void code_call_func(int funcname) {
	sprintf(strbucket, "%s\t%s%d", JA, FUNC_PRE, funcname);
	output(strbucket);
}

void code_start_bss() {
	static int bss_mark = 0;
	printf("%d\n", bss_mark);

	if (!bss_mark) {
		strcpy(strbucket, "section .bss");
		output(strbucket);
		bss_mark += 1;
	}
}

void code_start_text() {
	static int text_mark = 0;

	if (!text_mark) {
		strcpy(strbucket, "section .text");
		output(strbucket);
		++text_mark;
	}
}

void code_declare_global_var(int varname, int size) {
	sprintf(strbucket, "%d:\t%s %d", varname, GLOBAL_VAR_DEFINE, GLOBAL_VAR_LENGTH * size);
	output(strbucket);
}

void code_start_func(int funcname) {
	if (func_is_main(funcname))
		strcpy(strbucket, "global _start\n_start:");
	else 
		sprintf(strbucket, "global %s%d\n%s%d:", FUNC_PRE, funcname, FUNC_PRE, funcname);
	
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s, -4", ADDI, SP, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, 0(%s)", SW, FP, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s", MOVE, FP, SP);
	output(strbucket);
}

void code_clean_stack(int height) {
	sprintf(strbucket, "%s\t%s, %s, %d", ADDI, SP, SP, height);
	output(strbucket);
}

void code_end_func(int funcname) {
	sprintf(strbucket, "%s\t%s, %s", MOVE, SP, FP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, 0(%s)", LW, FP, SP);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s, 4", ADDI, SP, SP);
	output(strbucket);

	if (!func_is_main(funcname)) {
		sprintf(strbucket, "%s\t%s", JR, RA);
		output(strbucket);
	}
	else 
		code_end_main();
}

void code_sub_esp(int size) {
	sprintf(strbucket, "%s\t%s, %s, -%d", ADDI, SP, SP, size);
	output(strbucket);
}

void code_test_condition(int reg, int test, int labelno) {
	char regstr[REGSTR_LENGTH];
	getregstr(regstr, reg);

	sprintf(strbucket, "%s\t%s, %s, %d", ADDI, T8, T8, test);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s, %s%d", BEQ, regstr, T8, LABEL, labelno);
	output(strbucket);
}

/* Assign operator */
void code_op_assign(int target, int source) {
	char t_reg[VARSTR_LENGTH];
	char s_reg[REGSTR_LENGTH];

	getregstr(s_reg, source);
	getregstr(t_reg, target);

	// Fix
	sprintf(strbucket, "%s\t 0(%s), %s", MOVE, t_reg, s_reg);
	output(strbucket);
}

int code_get_array_offset(int baseoff, int idxreg, int varlength, int global) {
	char regstr[REGSTR_LENGTH];
	getregstr(regstr, idxreg);

	if (global == 0) {	/* general local var */
		sprintf(strbucket, "%s\t%s, %s", MOVE, T1, FP);
		output(strbucket);
	} 
	else if (global == -1) {	/* parameter */
		/* the array position in memory */
		sprintf(strbucket, "%s\t%s, %d(%s)", MOVE, T1, baseoff, FP);
		output(strbucket);
	} 
	else {		/* global var, just calculate the array index offset */
		sprintf(strbucket, "%s\t%s, 0", MOVE, T1);
		output(strbucket);
	}

	/* get the array index offset */
	sprintf(strbucket, "%s\t%s, %s, %d", ADDI, T7, T7, varlength);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s", MUL, regstr, T7);
	output(strbucket);

	sprintf(strbucket, "%s\t%s, %s, %s", ADD, T1, T1, T0);
	output(strbucket);

	if (global == 0) {
		sprintf(strbucket, "%s\t%s, %s, -%d", ADDI, T1, T1, abs(baseoff));
		output(strbucket);
	}

	return 2;		/* store in $t1 */
}

/* put the result in $t0 */
int code_op_binary(int v1, int v2, char *op) {
	char regstr1[REGSTR_LENGTH];
	char regstr2[REGSTR_LENGTH];

	getregstr(regstr1, v1);
	getregstr(regstr2, v2);

	if (strcmp(op, "+") == 0) {
		sprintf(strbucket, "%s\t%s, %s, %s", ADD, regstr1, regstr2, regstr1);
	} 
	else if (strcmp(op, "-") == 0) {
		sprintf(strbucket, "%s\t%s, %s, %s", SUB, regstr1, regstr2, regstr1);
	} 
	else if (strcmp(op, "*") == 0) {
		sprintf(strbucket, "%s\t%s, %s, %s", MUL, regstr1, regstr2, regstr1);
	} 
	else if (strcmp(op, "/") == 0) {
		sprintf(strbucket, "%s\t%s, %s, %s", DIV, regstr1, regstr2, regstr1);
		output(strbucket);
	} 
	else {		/* relop */
		if (strcmp(op, "==") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", SEQ, regstr1, regstr2, regstr1);
			output(strbucket);
		}
		else if (strcmp(op, "!=") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", SNE, regstr1, regstr2, regstr1);
			output(strbucket);
		}
		else if (strcmp(op, ">") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", SGT, regstr1, regstr2, regstr1);
			output(strbucket);
		}
		else if (strcmp(op, "<") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", SLT, regstr1, regstr2, regstr1);
			output(strbucket);
		}
		else if (strcmp(op, ">=") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", SGE, regstr1, regstr2, regstr1);
			output(strbucket);
		}
		else if (strcmp(op, "<=") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", SLE, regstr1, regstr2, regstr1);
			output(strbucket);
		}
		else if (strcmp(op, "&&") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", ANDI, T9, regstr1, regstr2);
			output(strbucket);

			sprintf(strbucket, "%s\t%s, %s, %s", SNE, regstr2, T9, regstr1);
		}
		else if (strcmp(op, "||") == 0) {
			sprintf(strbucket, "%s\t%s, %s, %s", ORI, T9, regstr1, regstr2);
			output(strbucket);

			sprintf(strbucket, "%s\t%s, %s, %s", SNE, regstr2, T9, regstr1);
		}

		output(strbucket);
	}

	return 1;		/* return which reg it stores the result */
}

int code_data_section() {
	static int data_mark = 0;

	if (!data_mark) {
		strcpy(strbucket, "section .data");
		output(strbucket);

		strcpy(strbucket, "numbers db \"0123456789\", 0xA");
		output(strbucket);

		strcpy(strbucket, "inputchar db 0");
		output(strbucket);

		++data_mark;
		return 0;
	}

	return data_mark;
}

/* output function */
void code_func_output() {
	strcpy(strbucket, "addi $sp, -4\nmove -4($fp), 0\nj G2\nG1:\nadd -4($fp), 1\naddi $sp, $sp, -4\nsw $t3, 0($sp)");
	output(strbucket);

	strcpy(strbucket, "G2:\nmove\t$t3, 0\nmove $t0, 8($fp)\nmove $t1, 10\ndiv $t1\nmove 8($fp), $t0");
	output(strbucket);

	strcpy(strbucket, "cmp $t0, 0\njnz G1\naddi $sp, $sp, -4\nsw $t3, 0($sp)\nadd -4($fp), 1\nj G3");
	output(strbucket);

	strcpy(strbucket, "G4:\nsub -4($fp), 1\nlw $t3, 0($sp)\naddi $sp, $sp, 4\nmove $t0, 4\nmove $t1, 1\nmove $t2, numbers");
	output(strbucket);

	strcpy(strbucket, "add $t2, $t3\nmove $t3, 1\nint 80h");
	output(strbucket);

	strcpy(strbucket, "G3:\ncmp -4($fp), 0\njnz G4\nmove $t0, 4\nmove $t1, 1\nlea $t2, 10(numbers)");
	output(strbucket);

	strcpy(strbucket, "move $t3, 1\nint 80h");
	output(strbucket);
}

/* input function */
void code_func_input() {
	strcpy(strbucket, "addi $sp, -4\nmove -4($fp), 0\nmove byte [inputchar], 0\nj G6");
	output(strbucket);

	strcpy(strbucket, "G5:\nmove $t0, -4($fp)\nmove $t1, 10\nmult $t1\nxor $t2, $t2");
	output(strbucket);

	strcpy(strbucket, "move byte cl, [inputchar]\naddi $t2, -48\nadd $t0, $t2\nmove -4($fp), $t0");
	output(strbucket);

	strcpy(strbucket, "G6:\nmove $t0, 03h\nmove $t1, 00h\nmove $t2, inputchar\nmove $t3, 01h");
	output(strbucket);

	strcpy(strbucket, "int 80h\ncmp byte [inputchar], 0ah\njne G5\nmove $t0, -4($fp)");
	output(strbucket);
}

static void code_end_main() {
	sprintf(strbucket, "move $t1, $t0\nmove $t0, 1\nint 80h");
	output(strbucket);
}