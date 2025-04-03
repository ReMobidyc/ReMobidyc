Extension { #name : 'RMDUniformDistributionXNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDUniformDistributionXNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter simulationModel east
	  - aRMDInterpreter simulationModel west * aRMDInterpreter random
	  + aRMDInterpreter simulationModel west
]

{ #category : '*ReMobidyc-Interpreter' }
RMDUniformDistributionXNode >> typecheckIn: aRMDInterpreter [

	^ type := RMDType unit: aRMDInterpreter patchLengthUnit
]
