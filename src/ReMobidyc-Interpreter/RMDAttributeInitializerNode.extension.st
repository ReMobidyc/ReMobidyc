Extension { #name : #RMDAttributeInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> evalIn: aRMDInterpreter [

	expression ifNotNil: [ 
		aRMDInterpreter
			initializeVariable: identifier
			with: (expression evalIn: aRMDInterpreter)
			ifAbsent: [ 
				^ RMDUnresolvedAttributeDefinitionError
					  signal: self
					  identifier: identifier ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := aRMDInterpreter
		        typeOfVariable: identifier
		        agent: nil
		        ifAbsent: [ 
			        ^ RMDUnresolvedAttributeDefinitionError
				          signal: self
				          identifier: identifier ].
	^ expression
		  ifNotNil: [ 
			  [ (expression typecheckIn: aRMDInterpreter) unify: type ]
				  on: RMDTypeUnificationError
				  do: [ :ex | 
					  ex resignalAs: (RMDTypeError
							   on: self
							   subnode: expression
							   type: ex type1
							   subnode: self
							   type: ex type2) ] ]
		  ifNil: [ type ]
]
