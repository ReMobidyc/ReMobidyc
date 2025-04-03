# Conditions

Conditions appear in guard conditions of actions/tasks and guarded expressions.

## relational conditions
| name | syntax | description |
| -----|------- | ----------- |
| equality | expr1  **=**  expr2  **=**  ...  **=**  exprn | all expr1 through exprn are equal values |
| less than | expr1  **<**  expr2  **<**  ...  **<**  exprn | expr1 < expr2 ∧ expr2 < expr3 ∧ ... ∧ exprn-1 < exprn | 
| less than or equal to | expr1  **<=**  expr2  **<=**  ...  **<=**  exprn | expr1 ≦ expr2 ∧ expr2 ≦ expr3 ∧ ... ∧ exprn-1 ≦ exprn | 
| greater than | expr1  **>**  expr2  **>**  ...  **>**  exprn | expr1 > expr2 ∧ expr2 > expr3 ∧ ... ∧ exprn-1 > exprn | 
| greater than or equal to | expr1  **>=**  expr  **>=**  ...  **>=**  exprn | expr1 ≧ expr2 ∧ expr2 ≧ expr3 ∧ ... ∧ exprn-1 ≧ exprn | 
| inequality | expr1  **/=**  expr2 | expr1 is not equal to expr2 |

## logical conditions
| name | syntax | description |
| -----|------- | ----------- |
| conjunction | cond1  **and**  cond2  **and**  ...  **and**  condn | all cond1 through condn are true |
| disjunction | cond1  **or**  cond2  **or**  ...  **or**  condn | either cond1 through condn is true | 
| negation |  **not**  cond | cond is false | 

## probablistic conditon
| name | syntax | description |
| -----|------- | ----------- |
| chance | expr  **chance**  | expr chance of being true, otherwise false |
