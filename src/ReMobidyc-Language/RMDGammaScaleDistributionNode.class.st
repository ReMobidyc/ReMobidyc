Class {
	#name : #RMDGammaScaleDistributionNode,
	#superclass : #RMDGammaDistributionNode,
	#instVars : [
		'scaleExpression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDGammaScaleDistributionNode >> = anObject [

	^ super = anObject and: [ scaleExpression = anObject scaleExpression ]
]

{ #category : #enumerating }
RMDGammaScaleDistributionNode >> childrenDo: aBlock [

	super childrenDo: aBlock.
	aBlock value: scaleExpression
]

{ #category : #enumerating }
RMDGammaScaleDistributionNode >> childrenTransform: aBlock [

	super childrenTransform: aBlock.
	scaleExpression := aBlock value: scaleExpression
]

{ #category : #comparing }
RMDGammaScaleDistributionNode >> hash [

	^ super hash bitXor: scaleExpression hash
]

{ #category : #testing }
RMDGammaScaleDistributionNode >> isGammaScaleDistributionNode [

	^ true
]

{ #category : #accessing }
RMDGammaScaleDistributionNode >> parameter2Expression [

	^ self scaleExpression
]

{ #category : #accessing }
RMDGammaScaleDistributionNode >> parameterName [

	^ 'scale'
]

{ #category : #copying }
RMDGammaScaleDistributionNode >> postCopy [

	super postCopy.
	scaleExpression := scaleExpression copy
]

{ #category : #printing }
RMDGammaScaleDistributionNode >> printOn: aStream [
	aStream nextPutAll: 'gamma '.
	shapeExpression printOn: aStream.
	aStream nextPutAll: ' scale '.
	scaleExpression printOn: aStream
]

{ #category : #printing }
RMDGammaScaleDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'gamma '.
	shapeExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' scale '.
	scaleExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDGammaScaleDistributionNode >> replaceChildren: aDictionary [

	super replaceChildren: aDictionary.
	scaleExpression := scaleExpression copyReplace: aDictionary
]

{ #category : #accessing }
RMDGammaScaleDistributionNode >> scaleExpression [

	^ scaleExpression
]

{ #category : #accessing }
RMDGammaScaleDistributionNode >> scaleExpression: aRMDExpressionNode [

	scaleExpression := aRMDExpressionNode
]
