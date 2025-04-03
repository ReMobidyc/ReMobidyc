Extension { #name : 'RMDLengthDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDLengthDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter patchLength
]

{ #category : '*ReMobidyc-Interpreter' }
RMDLengthDirectiveNode >> typecheckIn: aRMDInterpreter [

	^ type := RMDType unit: aRMDInterpreter patchLengthUnit
]
