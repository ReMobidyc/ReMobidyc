Class {
	#name : #RMDNotEqualNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNotEqualNode class >> expressions: anArrayOfRMDExpressionNode [
	^ anArrayOfRMDExpressionNode size = 2
		ifTrue: [ super expressions: anArrayOfRMDExpressionNode ]
		ifFalse: [ nil ]
]

{ #category : #evaluating }
RMDNotEqualNode >> evalIn: aRMDInterpreter [
	^ ((expressions at: 1) evalIn: aRMDInterpreter)
		~= ((expressions at: 2) evalIn: aRMDInterpreter)
]

{ #category : #testing }
RMDNotEqualNode >> isNotEqualNode [
	^ true
]

{ #category : #accessing }
RMDNotEqualNode >> operator [
	^ ' /= '
]
