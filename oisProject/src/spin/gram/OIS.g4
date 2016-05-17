grammar OIS;		
prog:	(expr NEWLINE)* ;
expr:	expr ('AND'|'OR') expr
    |	'HARD' constraint
    |   'SOFT' constraint
    ;
constraint: ingredient operator INT;
ingredient : STRING;
operator : '<' | '>' | '=' | '!=';
STRING : '"'  (~ ["\\])* '"';
NEWLINE : [\r\n]+ ;
INT     : [0-9]+ ;

WS
   : [ \t\n\r] + -> skip
   ;
