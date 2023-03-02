# Conditions

* Conditions appear in guard conditions of actions/tasks and guarded expressions.

## relational conditions
| name | syntax | description |
| -----|------- | ----------- |
| equality | _expr1_ `=` _expr2_ `=` ... `=` _exprn_ | all _expr1_ through _exprn_ are equal values |
| less than | _expr1_ `<` _expr2_ `<` ... `<` _exprn_ | _expr1_ < _expr2_ &and; _expr2_ < _expr3_ &and; ... &and; _exprn-1_ < exprn | 
| less than or equal to | _expr1_ `<=` _expr2_ `<=` ... `<=` _exprn_ | _expr1_ ≦ _expr2_ &and; _expr2_ ≦ _expr3_ &and; ... &and; _exprn-1_ ≦ exprn | 
| greater than | _expr1_ `>` _expr2_ `>` ... `>` _exprn_ | _expr1_ > _expr2_ &and; _expr2_ > _expr3_ &and; ... &and; _exprn-1_ > exprn | 
| greater than or equal to | _expr1_ `>=` _expr2_ `>=` ... `>=` _exprn_ | _expr1_ ≧ _expr2_ &and; _expr2_ ≧ _expr3_ &and; ... &and; _exprn-1_ ≧ exprn | 
| inequality | _expr1_ `/=` _expr2 | _expr1_ is not equal to _expr2_ |

## logical conditions
| name | syntax | description |
| -----|------- | ----------- |
| conjunction | _cond1_ `and` _cond2_ `and` ... `and` _condn_ | all _cond1_ through _condn_ are true |
| disjunction | _cond1_ `or` _cond2_ `or` ... `or` _condn_ | either _cond1_ through _condn_ is true | 
| negation | `not` _cond_ | _cond_ is false | 

## probablistic conditon
| name | syntax | description |
| -----|------- | ----------- |
| chance | _expr_ `chance` | _expr_ chance of being true, otherwise false |
