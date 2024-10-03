Class {
	#name : 'RMDChanceNode',
	#superclass : 'RMDConditionNode',
	#instVars : [
		'probability'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDChanceNode class >> probability: aRMDExpressionNode [

	^ self new
		  probability: aRMDExpressionNode;
		  yourself
]

{ #category : 'comparing' }
RMDChanceNode >> = anObject [

	^ self class = anObject class and: [ 
		  probability = anObject probability ]
]

{ #category : 'converting' }
RMDChanceNode >> asPresenter [

	^ RMDChancePresenter on: self
]

{ #category : 'enumerating' }
RMDChanceNode >> childrenDo: aBlock [

	aBlock value: probability
]

{ #category : 'enumerating' }
RMDChanceNode >> childrenTransform: aBlock [

	probability := aBlock value: probability
]

{ #category : 'comparing' }
RMDChanceNode >> hash [

	^ self class hash bitXor: probability hash
]

{ #category : 'testing' }
RMDChanceNode >> isChanceNode [

	^ true
]

{ #category : 'copying' }
RMDChanceNode >> postCopy [

	probability := probability copy
]

{ #category : 'accessing' }
RMDChanceNode >> precedence [
	^ 0
]

{ #category : 'printing' }
RMDChanceNode >> printOn: aStream [

	probability printOn: aStream.
	aStream nextPutAll: ' chance'
]

{ #category : 'printing' }
RMDChanceNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	probability
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' chance'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'accessing' }
RMDChanceNode >> probability [

	^ probability
]

{ #category : 'accessing' }
RMDChanceNode >> probability: aRMDExpression [

	probability := aRMDExpression
]

{ #category : 'rewriting' }
RMDChanceNode >> replaceChildren: aDictionary [

	probability := probability copyReplace: aDictionary
]
