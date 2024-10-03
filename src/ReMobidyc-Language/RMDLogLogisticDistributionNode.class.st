Class {
	#name : 'RMDLogLogisticDistributionNode',
	#superclass : 'RMDRandomNode',
	#instVars : [
		'scaleExpression',
		'shapeExpression'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDLogLogisticDistributionNode class >> scale: aRMDExpressionNode shape: anotherRMDExpressionNode [

	^ self new
		  scaleExpression: aRMDExpressionNode;
		  shapeExpression: anotherRMDExpressionNode;
		  yourself
]

{ #category : 'comparing' }
RMDLogLogisticDistributionNode >> = anObject [
	^ self class = anObject class
		and: [ shapeExpression = anObject shapeExpression
				and: [ scaleExpression = anObject scaleExpression ] ]
]

{ #category : 'enumerating' }
RMDLogLogisticDistributionNode >> childrenDo: aBlock [

	aBlock
		value: shapeExpression;
		value: scaleExpression
]

{ #category : 'enumerating' }
RMDLogLogisticDistributionNode >> childrenTransform: aBlock [

	shapeExpression := aBlock value: shapeExpression.
	scaleExpression := aBlock value: scaleExpression
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> distributionName [

	^ 'loglogistic'
]

{ #category : 'comparing' }
RMDLogLogisticDistributionNode >> hash [
	^ (self class hash bitXor: shapeExpression hash) bitXor: scaleExpression hash
]

{ #category : 'testing' }
RMDLogLogisticDistributionNode >> isLogLogisticDistributionNode [
	^ true
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> parameter1Expression [

	^ self scale
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> parameter2Expression [

	^ self shape
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> parameterName [

	^ 'shape'
]

{ #category : 'copying' }
RMDLogLogisticDistributionNode >> postCopy [

	shapeExpression := shapeExpression copy.
	scaleExpression := scaleExpression copy
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> precedence [
	^ 10
]

{ #category : 'printing' }
RMDLogLogisticDistributionNode >> printOn: aStream [

	aStream nextPutAll: 'loglogistic '.
	scaleExpression printOn: aStream.
	aStream nextPutAll: ' shape '.
	shapeExpression printOn: aStream
]

{ #category : 'printing' }
RMDLogLogisticDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'loglogistic '.
	scaleExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' shape '.
	scaleExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDLogLogisticDistributionNode >> replaceChildren: aDictionary [

	shapeExpression := shapeExpression copyReplace: aDictionary.
	scaleExpression := scaleExpression copyReplace: aDictionary
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> scaleExpression [

	^ scaleExpression
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> scaleExpression: aRMDExpressionNode [

	scaleExpression := aRMDExpressionNode
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> shapeExpression [

	^ shapeExpression
]

{ #category : 'accessing' }
RMDLogLogisticDistributionNode >> shapeExpression: aRMDExpressionNode [

	shapeExpression := aRMDExpressionNode
]
