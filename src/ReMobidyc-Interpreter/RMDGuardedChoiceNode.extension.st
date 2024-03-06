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
	| t |
	t := RMDType any.
	guardsAndChoices do: [ :assoc |
		assoc key typecheckIn: aRMDInterpreter.
		node := assoc value.
		t := (node typecheckIn: aRMDInterpreter) unify: t ].
	^ type := t ]
		on: RMDTypeUnificationError
		do: [ :ex |
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: node
					 type: ex type1
					 subnode: guardsAndChoices first value
					 type: ex type2) ]
]
