Extension { #name : #RMDDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectiveNode >> typecheckIn: aRMDInterpreter [

	[ ^ aRMDInterpreter typeOfDirective: directive ]
		on: KeyNotFound
		do: [ :ex | ex resignalAs: (RMDUndefinedDirectiveError on: self) ]
]
