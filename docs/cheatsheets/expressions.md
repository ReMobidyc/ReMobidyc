# Expressions

* All expressions are numeric with units.
* Any quantity is converted into a coherent derived units of the SI (International System of Units), for example, a length will be converted into meters, a weight into kilograms.

## Numeric presentation
| name | syntax | description |
| -----|------- | ----------- |
| numeric | 1 | numbers |
|  | 3.14 | numbers with decimal points |
|  | -1 | negative numbers |
|  | -3.14 | negative numbers with decimal points |
| π  | `π` | approximately equal to 3.14159 |
|   | `pi` | 


## Literal numbers
| name | syntax | description |
| -----|------- | ----------- |
| numeric with unit |  **numeric**  \[ **unit** \] |  **numeric**  as a quantity with the specified  **unit**,  |
| | | e.g. 100 [km/h]
| numeric without unit |  **numeric**  |  **numeric**  without a unit, |
| | | e.g. 21
|  ` ` | **numeric**  \[\] |  **numeric** with a dimensionless unit, |
| | | e.g. 21 \[\]

NOTE: A numeric without a unit is identical to the numeric with a dimensionless unit.


## Unit conversions
| name | syntax | description |
| -----|------- | ----------- |
| en-unit conversion |  **expr** \[ **unit** \] | the dimensionless value  **expr**  makes a quantity with the given  **unit**,
| | | e.g. (100+200)[m] is equivalent to 300[m] |
| de-unit conversion | ( **unit** )  **expr**  | the quantity  **expr**  is converted to a number in the given  **unit**,
| | | e.g. (m)(1 [km]) is equivalent to 1000.0 |

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
| utility variable |  **identifier**  | the value of the variable defined in the `where` clause in the task, |
| | | e.g. length |
| time | `time` | the current time |
| time step | `Δtime` | the time step of the simulation |
|  | `delta time`|  |

### Individual's Attributes 
The attributes of the performer of the task can be accessed in the following ways.
The performer can be either the world, a patch, or an animat.

| name | syntax | description |
| -----|------- | ----------- | 
| my attribute | `my`  **attribute** | the value of the individual's  **attribute**  |
| my incremental attribute | `my Δ`  **attribute** | the increment of the individual's  **attribute** since the last timestep  |
|  | `my delta`  **attribute** |  |
| my differential attribute | `my d/dt`  **attribute**  | the derivative of the individual's  **attribute**  |

### Patch Attributes 
Patch attributes can be used in the tasks of located agents, namely animats and patches.

| name | syntax | description |
| -----|------- | ----------- |
| spatial attribute | `here's`  **attribute**  | the value of the patch's  **attribute**  where the individual is located |
| spatial incremental attribute | `here's Δ`  **attribute**  | the increment of the patch's  **attribute**  where the individual is located |
| | `here's delta`  **attribute** | |
| spatial differential attribute | `here's d/dt`  **attribute**  | the derivative of the patch's  **attribute**  where the individual is located |

### World Attributes 
Any task definition can refer to the value of an attribute of the World agent.

| name | syntax | description |
| -----|------- | ----------- |
| global attribute | `world's`  **attribute**  | the value of the world global  **attribute**  |
| global incremental attribute | `world's Δ`  **attribute**  | the increment of the world global  **attribute**  |
| global differential attribute | `world's d/dt`  **attribute**  | the derivative of the world global  **attribute**  |

### Object Attributes 
Tasks that defines an interaction between two animats takes a peer animat, which is called  **object**.
For example, a task that a wolf eat a goat, `goat` is the object in the task.
The attributes of the object can be accessed in the following ways.

| name | syntax | description |
| -----|------- | ----------- |
| object attribute |  **object**`'s`  **attribute**  | the value of the  **object**'s  **attribute**  specified as the object of the task |
| object incremental attribute |  **object**`'s Δ`  **attribute**  | the increment of the  **object**'s  **attribute**  specified as the object of the task |
| | **object**`'s delta`  **attribute**  |  |
| object differential attribute |  **object**`'s d/dt`  **attribute**  | the derivative of the  **object**'s  **attribute**  specified as the object of the task |

## Spatial Expressions
| name | syntax | description |
| -----|------- | ----------- |
| direction of agent | `direction`  **agent**  | the direction of the  **agent**  from the individual |
| distance to agent | `distance`  **agent**  | the distance between the individual and the  **agent**  |
| direction of spatial gradient | `direction neighbor's`  **attribute**  | the direction of the gradient of  **attribute**  at the current patch |
| length of a patch | `length of here` | the length of the current patch |
| area of a patch | `area of here` | the area of the current patch |

## Population Expressions
| name | syntax | description |
| -----|------- | ----------- |
| number of agents in radius | `number of `  **agent**  `in`  **expression**  `radius` | the number of individual agents in the given radius |
| number of local agents | `number of `  **agent**  `here` | the number of individual agents in the same patch |
| number of agents | `number of `  **agent**  `in world` | the number of individual agents in the simulation |
| density of agents in radius | `number of `  **agent**  `in`  **expression**  `radius` | the number of individual agents per area in the given radius |
| density of local agents | `density of `  **agent**  `here` | the number of individual agents per area in the patch |
| density of agents | `density of `  **agent**  `in world` | the number of individual agents per area in the simulation |

## Math Expressions
| name | syntax | description |
| -----|------- | ----------- |
| parenthesis | `(`  **expr**  `)` | the value of the  **expr**  |
| negation | `-`  **expr**  | flips the sign of the value ||
| addition |  **expr1**  `+`  **expr2**  | sums the two values |
| subtraction |  **expr1**  `-`  **expr2**  | diffs the two values |
| product |  **expr1**  `*`  **expr2**  | multiplies the two values |
| fraction |  **expr1**  `/`  **expr2**  | the left-value over the right-value |
| remainder |  **expr1**  `%`  **expr2**  | the remainder of the left-value by the right-value |
| repeated multiplication |  **expr**  `^`  **digit**  |  **expr**  powered to  **digit**  ||
| square root | `sqrt(`**expr**`)` | the square root of  **expr**  which must be non-negative |
| power | `power(`**expr1**,  **expr2**`)` | the left value powered to the right value |
| | | **expr1**  and  **expr2**  must be non-dimensional|
| exponential | `exp(`**expr**`)` |  **e**  powered to  **expr** |
| | | the  **expr**  must be non-dimensional |
| natural logarithm | `ln(`**expr**`)`| the x such that  **e**  powered to  **x**  equals to  **expr**  |
| | | the  **expr**  must be non-dimensional |
| sine | `sin(`**expr**`)` | the sine of  **expr** |
| | | the  **expr**  must be an angle, such as radians and degrees |
| cosine | `cos(`**expr**`)` | the cosine of  **expr**  where the  **expr**  must be an angle |
| | | the  **expr**  must be an angle, such as radians and degrees |
| absolute value | `abs(`**expr**`)` | the value without the sign |
| positive | `positive(`**expr**`)` | the value if positive, otherwise `0` |
| round | `round(`**expr**`)` | the rounded value |
| floor | `floor(`**expr**`)` | the rounded-down value |
| ceiling | `ceiling(`**expr**`)` | the rounded-up value |
| maximum | `max(`**expr1**,  **expr2**, ...,  **exprn**`)` | the most value among arguments |
| | | all  **expr**  must have the same dimension |
| minimum | `min(`**expr1**,  **expr2**, ...,  **exprn**`)` | the least value among arguments |
| | | all  **expr**  must have the same dimension |
| average(mean) | `mean(`**expr1**,  **expr2**, ...,  **exprn**`)` | the mean value of arguments |
| | | all  **expr**  must have the same dimension |

## Random generators
| name | syntax | description |
| -----|------- | ----------- |
| uniform distribution | `uniform`  **expr1**  `to`  **expr2**  | a random number from the uniform distribtion in [**expr1**,  **expr2**] |
| | |  **expr1**  and  **expr2**  must have the same dimension |
| uniform integer distribution | `uniform**integer`  **expr1**  `to`  **expr2**  | a random integer from the uniform distribtion in [**expr1**,  **expr2**] |
| | |  **expr1**  and  **expr2**  must have the same dimension |
| normal distribution | `normal`  **expr1**  `sigma`  **expr2**  | a random number from the normal distribtion with the mean=**expr1**  and sigma=**expr2**  |
| | | **expr1**  and  **expr2**  must have the same dimension |
| gamma distribution | `gamma`  **expr1**  `scale`  **expr2**  | a random number from the gamma distribution with the shape=**expr1**  and scale=**expr2** |
| | |  **expr2**  must be non-dimensional |
| log-logistic (or Fisk) distribution | `loglogistic`  **expr1**  `shape`  **expr2**  | a random number from the log-logistic distribution with the scale=**expr1**  and shape=**expr2** |
| | `fisk`  **expr1**  `shape`  **expr2** |  **expr2**  must be non-dimensional |
