Class {
	#name : #RMDAssignableDifferentialPropertyVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAssignableDifferentialPropertyVariableNodeTest >> testInferType [
	| node unit unit2 |
	node := parser assignableDifferentialPropertyVariable end parse: 'my d/dt x'.
	unit := RMDUnit m.
	unit2 := unit / RMDUnit s.
	self deny: node isPetit2Failure.
	node propertyVariable unifyType: unit.
	self assert: node type isNil.
	self assert: node inferType equals: unit2.
	self assert: node type equals: unit2
]
