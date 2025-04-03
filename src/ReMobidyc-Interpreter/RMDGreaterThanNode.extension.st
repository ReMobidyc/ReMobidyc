Extension { #name : 'RMDGreaterThanNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDGreaterThanNode >> evalIn: aRMDInterpreter [
	| val |
	val := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index | 
		| val2 |
		val2 := (expressions at: index) evalIn: aRMDInterpreter.
		val <= val2
			ifTrue: [ ^ false ].
		val := val2 ].
	^ true
]
