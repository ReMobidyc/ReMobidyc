Extension { #name : #RMDNegationNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNegationNode >> evalIn: aRMDInterpreter [
	^ (condition evalIn: aRMDInterpreter) not
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNegationNode >> typecheckIn: aRMDInterpreter [
	condition typecheckIn: aRMDInterpreter
]
