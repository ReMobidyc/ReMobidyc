Extension { #name : #RMDStageDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDStageDirectiveNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter changeStage: animatIdentifier
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDStageDirectiveNode >> typecheckIn: aRMDInterpreter [

	| animatDefinition |
	animatIdentifier ifNil: [ 
		^ (RMDUnresolvedReferenceError on: self) signal ].
	animatDefinition := aRMDInterpreter
		                    animatDefinitionAt: animatIdentifier
		                    ifAbsent: [ 
		                    ^ RMDUndefinedAnimatError on: animatIdentifier ].
	animatDefinition species
	= aRMDInterpreter context subjectDefinition species ifFalse: [ 
		^ RMDSpeciesError
			  on: self
			  animatDefinition1: aRMDInterpreter context subjectDefinition
			  animatDefinition2: animatDefinition ].
	aRMDInterpreter changeStage: animatIdentifier
]
