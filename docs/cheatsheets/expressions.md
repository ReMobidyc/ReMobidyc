# Expressions

* All expressions are numeric with units.
* Any quantity is converted into a coherent derived units of the SI (International System of Units), for example, a length will be converted into meters, a weight into kilograms.

## Numeric presentation
| name | syntax | description |
| -----|------- | ----------- |
| decimal | _decimal_ | _decimal_ number with or without a sign and a decimal point |
| π  | `π` <br> `pi` |  the ratio of a circle's circumference to its diameter, approximately equal to 3.14159 |

## Literal numbers
| name | syntax | description |
| -----|------- | ----------- |
| numeric with unit | _numeric_ `[`_unit_`]` | _numeric_ as a quantity with the specified _unit_ |
| numeric without unit | _numeric_ <br> _numeric_ `[]` | _numeric_ without a unit or with a dimensionless unit |

## Unit conversions
| name | syntax | description |
| -----|------- | ----------- |
| en-unit conversion | _expr_`[`_unit_`]` | the dimensionless value `_expr_` makes a quantity with the given _unit_,<br> e.g. `(100+200)[m]` is equivalent to `300[m]` |
| de-unit conversion | `(`_unit_`)` _expr_ | the quantity _unit_ is converted to a number in the given _unit_,<br> e.g. `(m)(1 [km])` is equivalent to `1000.0` |

## Variable References
Various variables can be read in a task definition.
Most variables except utility variables can be either the current value, the increment since the last time step, or the derivative value.

### Simple Variables
Simple references can be used in any agent.
Utility variables are those defined in the `where` clause of a task.
Because they are temporary storage to perform the task, you can refer only to its current value.
The `time` represents the duration since the start of the simulation.
The increment of the `time` variable is naturally the time step of the simulation.

| name | syntax | description |
| -----|------- | ----------- |
| utility variable | _identifier_ | the value of the variable defined in the `where` clause in the task |
| time | `time` | the current time |
| time step | `Δtime` <br> `delta time`| the time step of the simulation |

### Individual's Attributes 
The attributes of the performer of the task can be accessed in the following ways.
The performer can be either the world, a patch, or an animat.

| name | syntax | description |
| -----|------- | ----------- |
| my attribute | `my` _identifier_ | the value of the individual's _attribute_ |
| my incremental attribute | `my Δ` _attribute_ <br> `my delta` _attribute_| the increment of the individual's _attribute_ |
| my differential attribute | `my d/dt` _attribute_ | the derivative of the individual's _attribute_ |

### Patch Attributes 
Patch attributes can be used in the tasks of located agents, namely animats and patches.

| name | syntax | description |
| -----|------- | ----------- |
| spatial attribute | `here's` _attribute_ | the value of the patch's _attribute_ where the individual is located |
| spatial incremental attribute | `here's Δ` _attribute_ <br> `here's delta` _attribute_| the increment of the patch's _attribute_ where the individual is located |
| spatial differential attribute | `here's d/dt` _attribute_ | the derivative of the patch's _attribute_ where the individual is located |

### World Attributes 
Any task definition can refer to the value of an attribute of the World agent.

| name | syntax | description |
| -----|------- | ----------- |
| global attribute | `world's` _attribute_ | the value of the world global _attribute_ |
| global incremental attribute | `world's Δ` _attribute_ | the increment of the world global _attribute_ |
| global differential attribute | `world's d/dt` _attribute_ | the derivative of the world global _attribute_ |

### Object Attributes 
Tasks that defines an interaction between two animats takes a peer animat, which is called _object_.
For example, a task that a wolf eat a goat, `goat` is the object in the task.
The attributes of the object can be accessed in the following ways.

| name | syntax | description |
| -----|------- | ----------- |
| object attribute | _object_`'s` _attribute_ | the value of the _object_'s _attribute_ specified as the object of the task |
| object incremental attribute | _object_`'s Δ` _attribute_ <br>_object_`'s delta` _attribute_ | the increment of the _object_'s _attribute_ specified as the object of the task |
| object differential attribute | _object_`'s d/dt` _attribute_ | the derivative of the _object_'s _attribute_ specified as the object of the task |

## Spatial Expressions
| name | syntax | description |
| -----|------- | ----------- |
| direction of agent | `direction` _agent_ | the direction of the _agent_ from the individual |
| distance to agent | `distance` _agent_ | the distance between the individual and the _agent_ |
| direction of spatial gradient | `direction neighbor's` _attribute_ | the direction of the gradient of _attribute_ at the current patch |

## Math Expressions
| name | syntax | description |
| -----|------- | ----------- |
| parenthesis | `(` _expr_ `)` | the value of the _expr_ |
| negation | `-` _expr_ | flips the sign of the value ||
| addition | _expr1_ `+` _expr2_ | sums the two values |
| subtraction | _expr1_ `-` _expr2_ | diffs the two values |
| product | _expr1_ `*` _expr2_ | multiplies the two values |
| fraction | _expr1_ `/` _expr2_ | the left-value over the right-value |
| repeated multiplication | _expr_ `^` _digit_ | _expr_ powered to _digit_ ||
| square root | `sqrt(`_expr_`)` | the square root of _expr_ which must be non-negative |
| power | `power(`_expr1_, _expr2_`)` | the left value powered to the right value <br>_expr1_ and _expr2_ must be non-dimensional|
| exponential | `exp(`_expr_`)` | _e_ powered to _expr_ <br> the _expr_ must be non-dimensional |
| natural logarithm | `ln(`_expr_`)`| the x such that _e_ powered to _x_ equals to _expr_ <br> the _expr_ must be non-dimensional |
| sine | `sin(`_expr_`)` | the sine of _expr_ <br> the _expr_ must be an angle, such as radians and degrees |
| cosine | `cos(`_expr_`)` | the cosine of _expr_ where the _expr_ must be an angle <br> the _expr_ must be an angle, such as radians and degrees |
| absolute value | `abs(`_expr_`)` | the value without the sign |
| positive | `positive(`_expr_`)` | the value if positive, otherwise `0` |
| round | `round(`_expr_`)` | the rounded value |
| floor | `floor(`_expr_`)` | the rounded-down value |
| ceiling | `ceiling(`_expr_`)` | the rounded-up value |
| maximum | `max(`_expr1_, _expr2_, ..., _exprn_`)` | the most value among arguments <br> all _expr_ must have the same dimension |
| minimum | `min(`_expr1_, _expr2_, ..., _exprn_`)` | the least value among arguments <br> all _expr_ must have the same dimension |
| average(mean) | `mean(`_expr1_, _expr2_, ..., _exprn_`)` | the mean value of arguments <br> all _expr_ must have the same dimension |

## Random generators
| name | syntax | description |
| -----|------- | ----------- |
| uniform distribution | `uniform` _expr1_ `to` _expr2_ | a random number from the uniform distribtion in [_expr1_, _expr2_] <br> _expr1_ and _expr2_ must have the same dimension |
| uniform integer distribution | `uniform_integer` _expr1_ `to` _expr2_ | a random integer from the uniform distribtion in [_expr1_, _expr2_] <br> _expr1_ and _expr2_ must have the same dimension |
| normal distribution | `normal` _expr1_ `sigma` _expr2_ | a random number from the normal distribtion with the mean=_expr1_ and sigma=_expr2_ <br> _expr1_ and _expr2_ must have the same dimension |
| gamma distribution | `gamma` _expr1_ `scale` _expr2_ | a random number from the gamma distribution with the shape=_expr1_ and scale=_expr2_ <br> _expr2_ must be non-dimensional |
| log-logistic (or Fisk) distribution | `loglogistic` _expr1_ `shape` _expr2_ <br> `fisk` _expr1_ `shape` _expr2_| a random number from the log-logistic distribution with the scale=_expr1_ and shape=_expr2_ <br> _expr2_ must be non-dimensional |
