Extension { #name : 'RMDAttributeInitializerNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> addressIn: aRMDInterpreter [

	^ aRMDInterpreter context subject + (self offsetIn: aRMDInterpreter)
]

{ #category : '*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> evalIn: aRMDInterpreter [

	expression ifNotNil: [ 
		aRMDInterpreter
			writeNext: ([ expression evalIn: aRMDInterpreter ]
					 on: RMDSemanticError
					 do: [ :ex | ex signalWithScope: self ])
			to: (self addressIn: aRMDInterpreter) ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDAttributeInitializerNode >> offsetIn: aRMDInterpreter [

	^ aRMDInterpreter context subjectDefinition
		  offsetAt: identifier
		  ifAbsent: [ ^ RMDUndefinedAttributeError signal: self ]
]

{ #category : '*ReMobidyc-Interpreter' }
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
			  [ 
			  ([ expression typecheckIn: aRMDInterpreter ]
				   on: RMDSemanticError
				   do: [ :ex | ex signalWithScope: self ]) unify: type ]
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
