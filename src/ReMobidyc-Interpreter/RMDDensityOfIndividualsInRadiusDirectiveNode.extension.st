Extension { #name : #RMDDensityOfIndividualsInRadiusDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDensityOfIndividualsInRadiusDirectiveNode >> evalIn: aRMDInterpreter [

	| r count |
	r := radius evalIn: aRMDInterpreter.
	count := self numberOfIndividualsIn: r with: aRMDInterpreter.
	^ count asFloat / r squared / Float pi
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDDensityOfIndividualsInRadiusDirectiveNode >> typecheckIn: aRMDInterpreter [

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
		do: [ :animatDef | ^ RMDType noDimension / RMDType area ].
	^ RMDUndefinedAnimatError on: animatName
]
