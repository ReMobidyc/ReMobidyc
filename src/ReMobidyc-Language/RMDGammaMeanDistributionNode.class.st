Class {
	#name : 'RMDGammaMeanDistributionNode',
	#superclass : 'RMDGammaDistributionNode',
	#instVars : [
		'meanExpression'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'comparing' }
RMDGammaMeanDistributionNode >> = anObject [

	^ super = anObject and: [ meanExpression = anObject meanExpression ]
]

{ #category : 'enumerating' }
RMDGammaMeanDistributionNode >> childrenDo: aBlock [

	super childrenDo: aBlock.
	aBlock value: meanExpression
]

{ #category : 'enumerating' }
RMDGammaMeanDistributionNode >> childrenTransform: aBlock [

	super childrenTransform: aBlock.
	meanExpression := aBlock value: meanExpression
]

{ #category : 'comparing' }
RMDGammaMeanDistributionNode >> hash [

	^ super hash bitXor: meanExpression hash
]

{ #category : 'testing' }
RMDGammaMeanDistributionNode >> isGammaMeanDistributionNode [

	^ true
]

{ #category : 'accessing' }
RMDGammaMeanDistributionNode >> meanExpression [

	^ meanExpression
]

{ #category : 'accessing' }
RMDGammaMeanDistributionNode >> meanExpression: aRMDExpressionNode [

	meanExpression := aRMDExpressionNode
]

{ #category : 'accessing' }
RMDGammaMeanDistributionNode >> parameter2Expression [

	^ self meanExpression
]

{ #category : 'accessing' }
RMDGammaMeanDistributionNode >> parameterName [

	^ 'mean'
]

{ #category : 'copying' }
RMDGammaMeanDistributionNode >> postCopy [

	super postCopy.
	meanExpression := meanExpression copy
]

{ #category : 'printing' }
RMDGammaMeanDistributionNode >> printOn: aStream [

	aStream nextPutAll: 'gamma '.
	shapeExpression printOn: aStream.
	aStream nextPutAll: ' mean '.
	meanExpression printOn: aStream
]

{ #category : 'printing' }
RMDGammaMeanDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'gamma '.
	shapeExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' mean '.
	meanExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDGammaMeanDistributionNode >> replaceChildren: aDictionary [

	super replaceChildren: aDictionary.
	meanExpression := meanExpression copyReplace: aDictionary
]
