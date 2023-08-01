Extension { #name : #RMDAttributeDeclarationNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeDeclarationNode >> evalIn: aRMDInterpreter [

	initializerExpression ifNotNil: [
		aRMDInterpreter
			writeNext: ([ initializerExpression evalIn: aRMDInterpreter ]
					 on: RMDSemanticError
					 do: [ :ex | ex signalWithScope: self ])
			to: aRMDInterpreter context subject
				+ (aRMDInterpreter context subjectDefinition
						 offsetAt: identifier
						 ifAbsent: [ ^ RMDUndefinedAttributeError signal: self ]) ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeDeclarationNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := RMDType unit: unit.
	initializerExpression ifNotNil: [ 
		[ 
		type := ([ initializerExpression typecheckIn: aRMDInterpreter ]
			         on: RMDSemanticError
			         do: [ :ex | ex signalWithScope: self ]) unify: type ]
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
