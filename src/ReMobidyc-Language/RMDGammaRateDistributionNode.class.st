Class {
	#name : 'RMDGammaRateDistributionNode',
	#superclass : 'RMDGammaDistributionNode',
	#instVars : [
		'rateExpression'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'comparing' }
RMDGammaRateDistributionNode >> = anObject [

	^ super = anObject and: [ rateExpression = anObject rateExpression ]
]

{ #category : 'enumerating' }
RMDGammaRateDistributionNode >> childrenDo: aBlock [

	super childrenDo: aBlock.
	aBlock value: rateExpression
]

{ #category : 'enumerating' }
RMDGammaRateDistributionNode >> childrenTransform: aBlock [

	super childrenTransform: aBlock.
	rateExpression := aBlock value: rateExpression
]

{ #category : 'comparing' }
RMDGammaRateDistributionNode >> hash [

	^ super hash bitXor: rateExpression hash
]

{ #category : 'testing' }
RMDGammaRateDistributionNode >> isGammaRateDistributionNode [

	^ true
]

{ #category : 'accessing' }
RMDGammaRateDistributionNode >> parameter2Expression [

	^ self rateExpression
]

{ #category : 'accessing' }
RMDGammaRateDistributionNode >> parameterName [

	^ 'rate'
]

{ #category : 'copying' }
RMDGammaRateDistributionNode >> postCopy [

	super postCopy.
	rateExpression := rateExpression copy
]

{ #category : 'printing' }
RMDGammaRateDistributionNode >> printOn: aStream [

	aStream nextPutAll: 'gamma '.
	shapeExpression printOn: aStream.
	aStream nextPutAll: ' rate '.
	rateExpression printOn: aStream
]

{ #category : 'printing' }
RMDGammaRateDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'gamma '.
	shapeExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' rate '.
	rateExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'accessing' }
RMDGammaRateDistributionNode >> rateExpression [

	^ rateExpression
]

{ #category : 'accessing' }
RMDGammaRateDistributionNode >> rateExpression: aRMDExpressionNode [

	rateExpression := aRMDExpressionNode
]

{ #category : 'rewriting' }
RMDGammaRateDistributionNode >> replaceChildren: aDictionary [

	super replaceChildren: aDictionary.
	rateExpression := rateExpression copyReplace: aDictionary
]
