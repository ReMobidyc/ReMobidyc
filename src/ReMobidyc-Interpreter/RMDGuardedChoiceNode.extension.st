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
	| type |
	type := RMDType any.
	guardsAndChoices
		do: [ :assoc | 
			assoc key typecheckIn: aRMDInterpreter.
			type := type unify: (assoc value typecheckIn: aRMDInterpreter) ].
	^ type
]
