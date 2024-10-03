Class {
	#name : 'RMDNotEqualNode',
	#superclass : 'RMDBinaryRelationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDNotEqualNode class >> expressions: anArrayOfRMDExpressionNode [
	^ anArrayOfRMDExpressionNode size = 2
		ifTrue: [ super expressions: anArrayOfRMDExpressionNode ]
		ifFalse: [ nil ]
]

{ #category : 'testing' }
RMDNotEqualNode >> isNotEqualNode [
	^ true
]

{ #category : 'accessing' }
RMDNotEqualNode >> operator [
	^ ' /= '
]
