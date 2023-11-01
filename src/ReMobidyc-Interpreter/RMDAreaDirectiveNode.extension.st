Extension { #name : #RMDAreaDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAreaDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter patchArea
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAreaDirectiveNode >> typecheckIn: aRMDInterpreter [

	^ RMDType area
]
