Class {
	#name : #RMDAssignablePropertyVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAssignablePropertyVariableNodeTest >> testInferType [
	| node unit |
	node := parser assignablePropertyVariable end
		parse: 'my x'.
	unit := RMDUnit m.
	self deny: node isPetit2Failure.
	node propertyVariable unifyType: unit.
	self assert: node type isNil.
	self assert: node inferType equals: unit.
	self assert: node type equals: unit
]
