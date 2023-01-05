Extension { #name : #RMDDirectionDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectionDirectiveNode >> evalIn: aRMDInterpreter [

	| x1 y1 x2 y2 |
	x1 := aRMDInterpreter my: 'x'.
	y1 := aRMDInterpreter my: 'y'.
	x2 := aRMDInterpreter agent: agentIdentifier s: 'x'.
	y2 := aRMDInterpreter agent: agentIdentifier s: 'y'.
	^ (x2 - x1 @ (y2 - y1)) theta
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectionDirectiveNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := RMDType m.
	self
		typecheck: (RMDAttributeVariableNode identifier: 'x' agent: nil)
		with: type
		in: aRMDInterpreter.
	self
		typecheck: (RMDAttributeVariableNode identifier: 'y' agent: nil)
		with: type
		in: aRMDInterpreter.
	self
		typecheck:
		(RMDAttributeVariableNode identifier: 'x' agent: agentIdentifier)
		with: type
		in: aRMDInterpreter.
	self
		typecheck:
		(RMDAttributeVariableNode identifier: 'y' agent: agentIdentifier)
		with: type
		in: aRMDInterpreter.
	^ RMDType rad
]