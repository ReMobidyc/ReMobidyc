Class {
	#name : 'RMDBinaryRelationNode',
	#superclass : 'RMDConditionNode',
	#instVars : [
		'expressions'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDBinaryRelationNode class >> expressions: anArrayOfRMDExpressionNode [
	^ self new
		expressions: anArrayOfRMDExpressionNode;
		yourself
]

{ #category : 'testing' }
RMDBinaryRelationNode class >> isAbstract [

	^ self == RMDBinaryRelationNode
]

{ #category : 'comparing' }
RMDBinaryRelationNode >> = anObject [
	^ self class = anObject class
		and: [ expressions = anObject expressions ]
]

{ #category : 'converting' }
RMDBinaryRelationNode >> asPresenter [

	^ RMDBinaryRelationPresenter on: self
]

{ #category : 'enumerating' }
RMDBinaryRelationNode >> childrenDo: aBlock [
	expressions do: aBlock
]

{ #category : 'enumerating' }
RMDBinaryRelationNode >> childrenTransform: aBlock [

	expressions := expressions collect: aBlock
]

{ #category : 'accessing' }
RMDBinaryRelationNode >> expressions [
	^ expressions
]

{ #category : 'accessing' }
RMDBinaryRelationNode >> expressions: anArrayOfRMDExpressionNode [
	expressions := anArrayOfRMDExpressionNode
]

{ #category : 'comparing' }
RMDBinaryRelationNode >> hash [
	^ self class hash bitXor: expressions hash
]

{ #category : 'testing' }
RMDBinaryRelationNode >> isBinaryRelationNode [
	^ true
]

{ #category : 'accessing' }
RMDBinaryRelationNode >> operator [
	^ self subclassResponsibility
]

{ #category : 'copying' }
RMDBinaryRelationNode >> postCopy [
	expressions := expressions collect: #copy
]

{ #category : 'accessing' }
RMDBinaryRelationNode >> precedence [
	^ 0
]

{ #category : 'printing' }
RMDBinaryRelationNode >> printOn: aStream [
	expressions
		do: [ :expr | expr printOn: aStream ]
		separatedBy: [ aStream nextPutAll: self operator ]
]

{ #category : 'printing' }
RMDBinaryRelationNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	expressions
		do: [ :expr | 
			expr
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ]
		separatedBy: [ aStream nextPutAll: self operator ].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDBinaryRelationNode >> replaceChildren: aDictionary [
	expressions := expressions
		collect: [ :node | node copyReplace: aDictionary ]
]
