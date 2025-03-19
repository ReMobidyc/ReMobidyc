Extension { #name : 'RMDDistanceDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDistanceDirectiveNode >> evalIn: aRMDInterpreter [

	| x1 y1 x2 y2 |
	x1 := aRMDInterpreter my: 'x'.
	y1 := aRMDInterpreter my: 'y'.
	x2 := aRMDInterpreter objects: 'x'.
	y2 := aRMDInterpreter objects: 'y'.
	^ ((x1 - x2) squared + (y1 - y2) squared) sqrt ifNanOrInfinite: [ 
		  RMDNotComputableError on: self ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDDistanceDirectiveNode >> typecheckIn: aRMDInterpreter [

	| t |
	t := RMDType unit: aRMDInterpreter patchLengthUnit.
	self
		typecheck: (RMDAttributeVariableNode identifier: 'x' agent: nil)
		with: t
		in: aRMDInterpreter.
	self
		typecheck: (RMDAttributeVariableNode identifier: 'y' agent: nil)
		with: t
		in: aRMDInterpreter.
	self
		typecheck:
		(RMDAttributeVariableNode identifier: 'x' agent: agentIdentifier)
		with: t
		in: aRMDInterpreter.
	self
		typecheck:
		(RMDAttributeVariableNode identifier: 'y' agent: agentIdentifier)
		with: t
		in: aRMDInterpreter.
	^ t
]
