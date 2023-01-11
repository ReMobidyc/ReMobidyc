Extension { #name : #RMDAttributeDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeDefinitionNode >> evalIn: aRMDInterpreter [

	[ 
	variable attributeVariable isNewAttributeVariableNode
		ifTrue: [ 
			| value |
			aRMDInterpreter context newIndividualsDo: [ :individual | 
				variable
					assign: (value := definitionBody evalIn: aRMDInterpreter)
					toNewIndividual: individual
					in: aRMDInterpreter ].
			^ value ]
		ifFalse: [ 
			^ variable
				  assign: (definitionBody evalIn: aRMDInterpreter)
				  in: aRMDInterpreter ] ]
		on: RMDSemanticError
		do: [ :ex | ex signalWithScope: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeDefinitionNode >> typecheckIn: aRMDInterpreter [

	^ [ 
	  ([ definitionBody typecheckIn: aRMDInterpreter ]
		   on: RMDSemanticError
		   do: [ :ex | ex signalWithScope: self ]) unify:
		  ([ variable typecheckIn: aRMDInterpreter ]
			   on: RMDSemanticError
			   do: [ :ex | ex signalWithScope: self ]) ]
		  on: RMDTypeUnificationError
		  do: [ :ex | 
			  ex resignalAs: (RMDTypeError
					   on: self
					   subnode: definitionBody
					   type: ex type1
					   subnode: variable
					   type: ex type2) ]
]
