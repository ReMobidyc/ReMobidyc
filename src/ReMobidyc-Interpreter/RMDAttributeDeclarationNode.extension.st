Extension { #name : #RMDAttributeDeclarationNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeDeclarationNode >> evalIn: aRMDInterpreter [

	initializerExpression ifNotNil: [ 
		aRMDInterpreter
			initializeVariable: identifier
			with: (initializerExpression evalIn: aRMDInterpreter)
			ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeDeclarationNode >> typecheckIn: aRMDInterpreter [

	^ [ unit unify: (initializerExpression typecheckIn: aRMDInterpreter) ]
		  on: RMDTypeUnificationError
		  do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
