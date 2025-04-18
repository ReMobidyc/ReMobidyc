Extension { #name : 'RMDDeltaTimeDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDeltaTimeDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter deltaTime
]

{ #category : '*ReMobidyc-Interpreter' }
RMDDeltaTimeDirectiveNode >> typecheckIn: aRMDInterpreter [

	^ type := RMDType unit: aRMDInterpreter deltaTimeUnit
]
