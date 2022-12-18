Extension { #name : #RMDAttributeInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> evalIn: aRMDInterpreter [

	expression ifNotNil: [ 
		aRMDInterpreter
			initializeVariable: identifier
			with: (expression evalIn: aRMDInterpreter)
			ifAbsent: [ 
				^ RMDUndefinedAttributeError signal:
					  (RMDAttributeVariableNode identifier: identifier agent: nil) ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := aRMDInterpreter
		        typeOfVariable: identifier
		        agent: nil
		        ifAbsent: [ 
			        ^ RMDUndefinedAttributeError signal:
				          (RMDAttributeVariableNode
					           identifier: identifier
					           agent: nil) ].
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
