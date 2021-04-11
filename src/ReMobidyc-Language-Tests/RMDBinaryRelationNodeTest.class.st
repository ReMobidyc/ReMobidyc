Class {
	#name : #RMDBinaryRelationNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDBinaryRelationNodeTest >> testInferType [
	| node unit |
	node := parser binaryRelation end parse: '1 [m/s] = 100 [cm/s]'.
	unit := RMDUnit m / RMDUnit s.
	self deny: node isPetit2Failure.
	node clearType.
	self assert: node type isNil.
	self assert: node inferType equals: unit.
	self assert: node type equals: unit.
	node := parser binaryRelation end parse: '1 [m/s] = 2 [m]'.
	self deny: node isPetit2Failure.
	node clearType.
	self assert: node type isNil.
	self should: [ node inferType ] raise: RMDTypeError
]
