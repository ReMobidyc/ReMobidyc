Extension { #name : #RMDEqualityNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDEqualityNode >> evalIn: aRMDInterpreter [
	| val |
	val := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index | 
		val = ((expressions at: index) evalIn: aRMDInterpreter)
			ifFalse: [ ^ false ] ].
	^ true
]
