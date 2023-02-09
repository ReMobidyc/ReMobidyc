Extension { #name : #RMDTimeDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTimeDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter time
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTimeDirectiveNode >> typecheckIn: aRMDInterpreter [

	^ RMDType time
]
