Extension { #name : #RMDAnimatInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> evalIn: aRMDInterpreter [

	| animatDefinition |
	animatDefinition := aRMDInterpreter simulationModel
		                    animatDefinitionAt: animat
		                    ifAbsent: [ 
		                    ^ (RMDUnresolvedReferenceError on: self) signal ].
	self population timesRepeat: [ 
		| individual |
		individual := aRMDInterpreter memory allocateAnimat:
			              animatDefinition.

		aRMDInterpreter
			withInitializerContextWithSubject: individual
			definition: animatDefinition
			do: [ 
				aRMDInterpreter
					initializeVariable: 'x'
					with:
						(RMDUniformDistributionXNode current evalIn: aRMDInterpreter)
					ifAbsent: [ ^ RMDUnresolvedReferenceError on: self ];
					initializeVariable: 'y'
					with:
						(RMDUniformDistributionYNode current evalIn: aRMDInterpreter)
					ifAbsent: [ ^ RMDUnresolvedReferenceError on: self ].
				animatDefinition evalIn: aRMDInterpreter.
				super evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDAnimatInitializerNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter
		withContext:
		(aRMDInterpreter newTypecheckContextForAnimat: self animat)
		do: [ super typecheckIn: aRMDInterpreter ]
]
