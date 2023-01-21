Extension { #name : #RMDAnimatInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> evalIn: aRMDInterpreter [

	| animatDefinition |
	animatDefinition := aRMDInterpreter simulationModel
		                    animatDefinitionAt: animat
		                    ifAbsent: [ 
		                    ^ (RMDUnresolvedReferenceError on: self) signal ].
	self population timesRepeat: [ 
		| individual xOffset yOffset |
		individual := aRMDInterpreter memory allocateAnimat:
			              animatDefinition.
		xOffset := animatDefinition
			           offsetAt: 'x'
			           ifAbsent: [ ^ RMDUndefinedAttributeError signal: self ].
		yOffset := animatDefinition
			           offsetAt: 'y'
			           ifAbsent: [ ^ RMDUndefinedAttributeError signal: self ].
		aRMDInterpreter
			withInitializerContextWithSubject: individual
			definition: animatDefinition
			do: [ 
				aRMDInterpreter
					write:
						(RMDUniformDistributionXNode current evalIn: aRMDInterpreter)
					to: individual + xOffset;
					write:
						(RMDUniformDistributionYNode current evalIn: aRMDInterpreter)
					to: individual + yOffset.
				animatDefinition evalIn: aRMDInterpreter.
				super evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context
		subjectDefinition: (aRMDInterpreter
				 animatDefinitionAt: self animat
				 ifAbsent: [ RMDUndefinedAnimatError signal: self animat ]);
		loadUtilityDefinitions: utilityDefinitions.
	^ super typecheckIn: aRMDInterpreter
]
