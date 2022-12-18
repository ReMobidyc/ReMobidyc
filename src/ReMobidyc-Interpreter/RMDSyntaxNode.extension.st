Extension { #name : #RMDSyntaxNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSyntaxNode >> weakTypecheckIn: aRMDTypechecker [

	^ [ self typecheckIn: aRMDTypechecker ]
		  on: RMDUnresolvedPlaceholderError
		  do: [ :ex | ex resume: RMDType any ]
]
