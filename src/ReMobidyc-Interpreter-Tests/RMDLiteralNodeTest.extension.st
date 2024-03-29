Extension { #name : #RMDLiteralNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDLiteralNodeTest >> testEvalIn [

	| literal |
	literal := parser literal parse: '2'.
	self assert: (literal evalIn: interpreter) closeTo: 2.
	literal := parser literal parse: '2[]'.
	self assert: (literal evalIn: interpreter) closeTo: 2.
	literal := parser literal parse: '2[m]'.
	self assert: (literal evalIn: interpreter) closeTo: 2.
	literal := parser literal parse: '2[cm]'.
	self assert: (literal evalIn: interpreter) closeTo: 0.02.
	literal := parser literal parse: '450.0 [m]'.
	self assert: (literal evalIn: interpreter) closeTo: 450.0
]
