Extension { #name : 'RMDUniformIntegerDistributionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDUniformIntegerDistributionNode >> evalIn: aRMDInterpreter [

	| to from |
	to := (toExpression evalIn: aRMDInterpreter) rounded.
	from := (fromExpression evalIn: aRMDInterpreter) rounded.
	^ ((to - from) abs + 1 * aRMDInterpreter random) floor
	  + (from min: to) min: (from max: to) max: (from min: to)
]
