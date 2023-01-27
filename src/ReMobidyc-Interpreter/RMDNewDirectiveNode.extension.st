Extension { #name : #RMDNewDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewDirectiveNode >> evalIn: aRMDInterpreter [

	animatIdentifier ifNil: [ 
		^ (RMDUnresolvedReferenceError on: self) signal ].

	aRMDInterpreter newIndividual: animatIdentifier quantity: (quantity
			 ifNil: [ 1 ]
			 ifNotNil: [ (quantity evalIn: aRMDInterpreter) floor ])
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNewDirectiveNode >> typecheckIn: aRMDInterpreter [

	| animatDefinition |
	animatIdentifier ifNil: [ 
		^ RMDUnresolvedPlaceholderError signal: self ].
	quantity ifNotNil: [ 
		[ 
		(quantity typecheckIn: aRMDInterpreter) unify:
			RMDUnitType noDimension ]
			on: RMDTypeUnificationError
			do: [ :ex | 
				ex resignalAs: (RMDTypeError
						 on: self
						 subnode: quantity
						 type: ex type1
						 subnode: self
						 type: ex type2) ] ].
	animatDefinition := aRMDInterpreter simulationModel
		                    animatDefinitionAt: animatIdentifier
		                    ifAbsent: [ 
		                    ^ RMDUndefinedAnimatError on: animatIdentifier ].
	animatDefinition species
	= aRMDInterpreter context subjectDefinition species ifFalse: [ 
		^ RMDSpeciesError
			  on: self
			  animatDefinition1: aRMDInterpreter context subjectDefinition
			  animatDefinition2: animatDefinition ].
	aRMDInterpreter newIndividual: animatIdentifier
]
