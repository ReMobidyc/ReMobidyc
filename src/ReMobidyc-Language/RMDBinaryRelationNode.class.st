Class {
	#name : #RMDBinaryRelationNode,
	#superclass : #RMDConditionNode,
	#instVars : [
		'expressions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDBinaryRelationNode class >> expressions: anArrayOfRMDExpressionNode [
	^ self new
		expressions: anArrayOfRMDExpressionNode;
		yourself
]

{ #category : #comparing }
RMDBinaryRelationNode >> = anObject [
	^ self class = anObject class
		and: [ expressions = anObject expressions ]
]

{ #category : #enumerating }
RMDBinaryRelationNode >> childrenDo: aBlock [
	expressions do: aBlock
]

{ #category : #accessing }
RMDBinaryRelationNode >> expressions [
	^ expressions
]

{ #category : #accessing }
RMDBinaryRelationNode >> expressions: anArrayOfRMDExpressionNode [
	expressions := anArrayOfRMDExpressionNode
]

{ #category : #comparing }
RMDBinaryRelationNode >> hash [
	^ self class hash bitXor: expressions hash
]

{ #category : #'type checking' }
RMDBinaryRelationNode >> inferType [
	expressions
		do: [ :expression | self unifyType: expression inferType ].
	^ type
]

{ #category : #testing }
RMDBinaryRelationNode >> isBinaryRelationNode [
	^ true
]

{ #category : #accessing }
RMDBinaryRelationNode >> operator [
	^ self subclassResponsibility
]

{ #category : #copying }
RMDBinaryRelationNode >> postCopy [
	expressions := expressions collect: #copy
]

{ #category : #accessing }
RMDBinaryRelationNode >> precedence [
	^ 0
]

{ #category : #printing }
RMDBinaryRelationNode >> printOn: aStream [
	expressions
		do: [ :expr | expr printOn: aStream ]
		separatedBy: [ aStream nextPutAll: self operator ]
]

{ #category : #rewriting }
RMDBinaryRelationNode >> replaceChildren: aDictionary [
	expressions := expressions
		collect: [ :node | node copyReplace: aDictionary ]
]
