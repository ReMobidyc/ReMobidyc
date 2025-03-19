Extension { #name : 'RMDNotEqualNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDNotEqualNode >> evalIn: aRMDInterpreter [
	^ ((expressions at: 1) evalIn: aRMDInterpreter)
		~= ((expressions at: 2) evalIn: aRMDInterpreter)
]
