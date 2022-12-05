Extension { #name : #RMDAttributeInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> evalIn: aRMDInterpreter [

	expression ifNotNil: [ 
		aRMDInterpreter
			initializeVariable: identifier
			with: (expression evalIn: aRMDInterpreter)
			ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := aRMDInterpreter
		        typeOfVariable: identifier
		        agent: nil
		        ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ].
	^ expression
		  ifNotNil: [ 
			  [ type unify: (expression typecheckIn: aRMDInterpreter) ]
				  on: RMDTypeUnificationError
				  do: [ :ex | 
				  ex resignalAs: (RMDTypeError on: self with: ex type1) ] ]
		  ifNil: [ type ]
]
