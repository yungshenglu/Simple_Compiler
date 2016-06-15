#ifndef COMMAND_H
#define COMMAND_H

#define LABEL "L"//
#define BNE "bne"//
#define BEQ "beq"//
#define SLT "slt"//

#define MOVE "move"//
#define J "j"//

#define ADD "add"//
#define ADDI "addi"//
#define SUB "sub"//
#define MULT "mult"//
#define DIV "div"//

#define SW "sw"//
#define LW "lw"//

#define LEA "lea"//
#define LEAVE "leave"//

#define JR "jr"//

#define MOVZX "movzx"//
#define JAL "jal"//

#define T0 "$t0"//
#define T1 "$t1"//
#define T2 "$t2"//
#define T3 "$t3"//
#define T5 "$t5"//
#define T6 "$t6"//
#define T7 "$t7"//mult
#define T8 "$t8"//branch
#define T9 "$t9"//1

#define FP "$fp"//
#define SP "$sp"//
#define LO "$t4"//
#define ZR "$zero"//

#define GLOBAL_VAR_LENGTH 2
#define GLOBAL_VAR_DEFINE "resw"
#define VARSTR_LENGTH 20
#define REGSTR_LENGTH 4

#define MAX_STR_LENGTH 300

#define FUNC_PRE "F_"
#define GDATA_PRE "D_"

char strbucket[MAX_STR_LENGTH];

void output(char *str);

static int func_is_main(int funcname);

static void getvarstr(char *varstr, int offset);
static int getregstr(char *regstr, int reg);

int creat_label();
void code_label(int labelno);

void code_jmp(int labelno);
void code_pop(int reg);

void code_lea_global(int target, int addr, int offset);
void code_lea_local(int target, int var);

void code_move_reg(int target, int source);

void code_push_mem(int addr, int offset);
void code_push_reg(int reg, int mem);
void code_push_ind(int idx);
void code_push_cons(int constant);
void code_push_global_var(int var, int offset);
void code_push_global_array(int var);

void code_call_func(int funcname);

void code_start_bss();
void code_start_text();

void code_declare_global_var(int varname, int size);

void code_start_func(int funcname);
void code_clean_stack(int height);
void code_end_func(int funcname);
void code_sub_esp(int size);

void code_test_condition(int reg, int test, int labelno);
void code_op_assign(int target, int source);
int code_get_array_offset(int baseoff, int idxreg, int varlength, int global);
int code_op_binary(int v1, int v2, char *op);

int code_data_section();

void code_func_output();
void code_func_input();

static void code_end_main();

#endif