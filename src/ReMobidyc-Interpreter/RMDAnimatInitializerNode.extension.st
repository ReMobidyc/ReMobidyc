Extension { #name : #RMDAnimatInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> evalIn: aRMDInterpreter [

	| animatDefinition |
	animatDefinition := aRMDInterpreter simulationModel
		                    animatDefinitionAt: animat
		                    ifAbsent: [ 
		                    ^ (RMDUndefinedAnimatError on: self) signal ].
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
					writeNext:
						(RMDUniformDistributionXNode current evalIn: aRMDInterpreter)
					to: individual + xOffset;
					writeNext:
						(RMDUniformDistributionYNode current evalIn: aRMDInterpreter)
					to: individual + yOffset.
				animatDefinition evalIn: aRMDInterpreter.
				super evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context
		subjectDefinition: (aRMDInterpreter simulationModel
				 animatDefinitionAt: self animat
				 ifAbsent: [ RMDUndefinedAnimatError signal: self animat ]);
		loadUtilityDefinitions: utilityDefinitions.
	^ super typecheckIn: aRMDInterpreter
]
