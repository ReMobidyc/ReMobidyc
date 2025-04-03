Extension { #name : 'RMDConjunctionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDConjunctionNode >> evalIn: aRMDInterpreter [
	^ conditions allSatisfy: [ :cond | cond evalIn: aRMDInterpreter ]
]
