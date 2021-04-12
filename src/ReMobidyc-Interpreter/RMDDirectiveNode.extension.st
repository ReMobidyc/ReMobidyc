Extension { #name : #RMDDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectiveNode >> typecheckIn: aRMDInterpreter [
	^ aRMDInterpreter typeOfDirective: directive
]
