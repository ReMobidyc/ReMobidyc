Extension { #name : #RMDStageDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDStageDirectiveNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter changeStage: animatIdentifier
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDStageDirectiveNode >> typecheckIn: aRMDInterpreter [

	animatIdentifier ifNil: [ 
		^ (RMDUnresolvedReferenceError on: self) signal ].
	aRMDInterpreter newIndividual: animatIdentifier
]
