Extension { #name : #RMDNegationNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNegationNode >> evalIn: aRMDInterpreter [
	^ (condition evalIn: aRMDInterpreter) not
]
