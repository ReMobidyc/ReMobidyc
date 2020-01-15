Extension { #name : #RMDDisjunctionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDisjunctionNode >> evalIn: aRMDInterpreter [
	^ conditions anySatisfy: [ :cond | cond evalIn: aRMDInterpreter ]
]
