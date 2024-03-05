Extension { #name : #RMDNumberOfIndividualsInRadiusDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInRadiusDirectiveNode >> evalIn: aRMDInterpreter [

	^ self
		  numberOfIndividualsIn: (radius evalIn: aRMDInterpreter)
		  with: aRMDInterpreter
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInRadiusDirectiveNode >> typecheckIn: aRMDInterpreter [

	[ (radius typecheckIn: aRMDInterpreter) unify: RMDType length ]
		on: RMDTypeUnificationError
		do: [ :ex |
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: radius
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	aRMDInterpreter simulationModel
		stagesOf: animatName
		do: [ :animatDef | ^ type := RMDType noDimension ].
	^ RMDUndefinedAnimatError on: animatName
]
