Extension { #name : #RMDUniformDistributionYNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionYNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter simulationModel north
	  - aRMDInterpreter simulationModel south * aRMDInterpreter random
	  + aRMDInterpreter simulationModel south
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionYNode >> typecheckIn: aRMDInterpreter [
	^ RMDType m
]
