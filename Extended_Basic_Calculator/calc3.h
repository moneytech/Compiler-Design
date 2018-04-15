typedef enum { typeCon,typeFloat, typeId, typeOpr } nodeEnum;
/* constants */
typedef struct {
 int value;
  /* value of constant */
} conNodeType;
typedef struct{
double float_value;
int count;
}conNode1Type;
/* identifiers */
typedef struct {
 int i; /* subscript to sym array */
} idNodeType;
/* operators */
typedef struct {
 int oper; /* operator */
 int nops; /* number of operands */
 struct nodeTypeTag *op[1]; /* operands (expandable) */
} oprNodeType;
typedef struct nodeTypeTag {
 nodeEnum type; /* type of node */
 /* union must be last entry in nodeType */
 /* because operNodeType may dynamically increase */
 union {
 conNodeType con; /* constants */
 conNode1Type Float;
 idNodeType id; /* identifiers */
 oprNodeType opr; /* operators */
 };
} nodeType;
extern int sym[26]; 
