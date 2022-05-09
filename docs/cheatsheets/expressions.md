# Expressions

* All expressions are numeric with units.
* Any quantity is converted into a coherent derived units of the SI (International System of Units), for example, a length will be converted into meters, a weight into kilograms.

## Variable References
| name | syntax | description |
| -----|------- | ----------- |
| utility variable | _identifier_ | the value of the variable defined in the `where` clause |
| time | `time` | the current time |
| my attribute | `my` _identifier_ | the value of the individual's _attribute_ |
| spatial attribute | `here's` _attribute_ | the value of the patch's _attribute_ where the individual is located |
| object attribute | agent`'s` _attribute_ | the value of the agent's _attribute_ specified as the object of the task |
| time step | `Δtime` <br> `delta time`| the time step of the simulation |
| my incremental attribute | `my Δ` _attribute_ <br> `my delta` _attribute_| the increment of the individual's _attribute_ |
| spatial incremental attribute | `here's Δ` _attribute_ <br> `here's delta` _attribute_| the increment of the patch's _attribute_ where the individual is located |
| object incremental attribute | _agent_`'s Δ` _attribute_ <br>_agent_`'s delta` _attribute_ | the increment of the _agent_'s _attribute_ specified as the object of the task |
| my differential attribute | `my d/dt` _attribute_ | the value of the individual's _attribute_ |
| spatial differential attribute | `here's d/dt` _attribute_ | the value of the patch's _attribute_ where the individual is located |
| object differential attribute | agent`'s d/dt` _attribute_ | the value of the _agent_'s _attribute_ specified as the object of the task |

## Spatial Expressions
| name | syntax | description |
| -----|------- | ----------- |
| direction of agent | `direction` _agent_ | the direction of the _agent_ from the individual |
| distance to agent | `distance` _agent_ | the distance between the individual and the _agent_ |
| direction of spatial gradient attribute | `direction neighbor's` _attribute_ | the direction of ∇ _attribute_ at the current patch |

## Math Expressions
| name | syntax | description |
| -----|------- | ----------- |
| parenthesis | `(` _expr_ `)` | the value of the _expr_ |
| negation | `-` _expr_ | flips the sign of the value ||
| addition | _expr1_ `+` _expr2_ | sums the two values |
| subtraction | _expr1_ `-` _expr2_ | diffs the two values |
| product | _expr1_ `*` _expr2_ | multiplies the two values |
| fraction | _expr1_ `/` _expr2_ | the left-value over the right-value |
| repeated multiplication | _expr_ `^` _digit_ | _expr_ powered to _digit_ |
| power | `power(`_expr1_, _expr2_`)` | the left value powered to the right value <br>_expr1_ and _expr2_ must be non-dimensional|
| exponential | `exp(`_expr_`)` | _e_ powered to _expr_ <br> the _expr_ must be non-dimensional |
| natural logarithm | `ln(`_expr_`)`| the x such that _e_ powered to _x_ equals to _expr_ <br> the _expr_ must be non-dimensional |
| sine | `sin(`_expr_`)` | the sine of _expr_ <br> the _expr_ must be an angle, such as radians and degrees |
| cosine | `cos(`_expr_`)` | the cosine of _expr_ where the _expr_ must be an angle <br> the _expr_ must be an angle, such as radians and degrees |
| absolute value | `abs(`_expr_`)` | the value without the sign |
| positive | `positive(`_expr_`)` | the value if positive, otherwise `0` |
| maximum | `max(`_expr1_, _expr2_, ..., _exprn_`)` | the most value among arguments <br> all _expr_ must have the same dimension |
| minimum | `min(`_expr1_, _expr2_, ..., _exprn_`)` | the least value among arguments <br> all _expr_ must have the same dimension |
| average(mean) | `mean(`_expr1_, _expr2_, ..., _exprn_`)` | the mean value of arguments <br> all _expr_ must have the same dimension |

## Random generators
| name | syntax | description |
| -----|------- | ----------- |
| uniform distribution | `uniform` _expr1_ `to` _expr2_ | a random number from the uniform distribtion in [_expr1_, _expr2_] <br> _expr1_ and _expr2_ must have the same dimension |
| normal distribution | `normal` _expr1_ `sigma` _expr2_ | a random number from the normal distribtion with the mean=_expr1_ and sigma=_expr2_ <br> _expr1_ and _expr2_ must have the same dimension |
| gamma distribution | `gamma` _expr1_ `scale` _expr2_ | a random number from the gamma distribution with the shape=_expr1_ and scale=_expr2_ <br> _expr2_ must be non-dimensional |
