Extension { #name : #RMDSyntaxNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSyntaxNode >> typecheckIn: aRMDInterpreter subject: aString object: anotherString [

	^ self typecheckIn: aRMDInterpreter
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDSyntaxNode >> weakTypecheckIn: aRMDTypechecker [

	^ [ self typecheckIn: aRMDTypechecker ]
		  on: RMDUnresolvedPlaceholderError
		  do: [ :ex | ex resume: RMDType any ]
]
