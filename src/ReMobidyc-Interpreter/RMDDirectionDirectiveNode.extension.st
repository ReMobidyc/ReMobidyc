Extension { #name : 'RMDDirectionDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionDirectiveNode >> evalIn: aRMDInterpreter [

	| x1 y1 x2 y2 |
	x1 := aRMDInterpreter my: 'x'.
	y1 := aRMDInterpreter my: 'y'.
	x2 := aRMDInterpreter objects: 'x'.
	y2 := aRMDInterpreter objects: 'y'.
	^ (x2 - x1 @ (y2 - y1)) theta
]

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionDirectiveNode >> typecheckIn: aRMDInterpreter [

	| t |
	t := RMDType length.
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
	^ type := RMDType angle
]
