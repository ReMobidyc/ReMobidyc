Class {
	#name : #RMDAssignableDeltaPropertyVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAssignableDeltaPropertyVariableNodeTest >> testInferType [
	| node unit |
	node := parser assignableDeltaPropertyVariable end
		parse: 'my delta x'.
	unit := RMDUnit m.
	self deny: node isPetit2Failure.
	node propertyVariable unifyType: unit.
	self assert: node type isNil.
	self assert: node inferType equals: unit.
	self assert: node type equals: unit
]
