#ifndef NODE_H
#define NODE_H

typedef enum { TYPE_CONTENT, TYPE_INDEX, TYPE_OP } Node_enum;

typedef struct OPNODE {
	int op_name;
	int operand;
	struct NODE *node[1];
} OpNode;

typedef struct NODE {
	Node_enum type;
	union {
		int content;
		int index;
		OpNode op;
	};
} Node;

#endif