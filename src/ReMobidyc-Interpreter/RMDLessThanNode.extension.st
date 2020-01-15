Extension { #name : #RMDLessThanNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDLessThanNode >> evalIn: aRMDInterpreter [
	| val |
	val := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index | 
		| val2 |
		val2 := (expressions at: index) evalIn: aRMDInterpreter.
		val2 <= val
			ifTrue: [ ^ false ].
		val := val2 ].
	^ true
]
