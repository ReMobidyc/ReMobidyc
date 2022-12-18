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

	| type |
	type := RMDType unit: unit.
	initializerExpression ifNotNil: [ 
		[ 
		type := (initializerExpression typecheckIn: aRMDInterpreter) unify:
			        unit ]
			on: RMDTypeUnificationError
			do: [ :ex | 
				ex resignalAs: (RMDTypeError
						 on: self
						 subnode: initializerExpression
						 type: ex type1
						 subnode: self
						 type: ex type2) ] ].
	^ type
]
