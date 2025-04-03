Extension { #name : 'RMDEqualityNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDEqualityNode >> evalIn: aRMDInterpreter [

	| val1 |
	val1 := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index |
		val1 =~= ((expressions at: index) evalIn: aRMDInterpreter) ifFalse: [
			^ false ] ].
	^ true
]
