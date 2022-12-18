Extension { #name : #RMDGuardedChoiceNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGuardedChoiceNode >> evalIn: aRMDInterpreter [
	guardsAndChoices
		do: [ :assoc | 
			(assoc key evalIn: aRMDInterpreter) = true
				ifTrue: [ ^ assoc value evalIn: aRMDInterpreter ] ].
	^ self error: 'All guards failed'
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGuardedChoiceNode >> typecheckIn: aRMDInterpreter [

	| node |
	[ 
	| type |
	type := RMDType any.
	guardsAndChoices do: [ :assoc | 
		assoc key typecheckIn: aRMDInterpreter.
		node := assoc value.
		type := (node typecheckIn: aRMDInterpreter) unify: type ].
	^ type ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: node
					 type: ex type1
					 subnode: guardsAndChoices first value
					 type: ex type2) ]
]
