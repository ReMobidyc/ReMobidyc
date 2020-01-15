Extension { #name : #RMDGuardedChoiceNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGuardedChoiceNode >> evalIn: aRMDInterpreter [
	guardsAndChoices
		do: [ :assoc | 
			(assoc key evalIn: aRMDInterpreter) = true
				ifTrue: [ ^ assoc value evalIn: aRMDInterpreter ] ].
	^ self error: 'All guards failed'
]
