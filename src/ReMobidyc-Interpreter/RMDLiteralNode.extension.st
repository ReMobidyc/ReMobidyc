Extension { #name : 'RMDLiteralNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDLiteralNode >> evalIn: aRMDInterpreter [
	^ self numeric
]

{ #category : '*ReMobidyc-Interpreter' }
RMDLiteralNode >> typecheckIn: aRMDInterpreter [

	^ type := RMDType unit: unit
]
