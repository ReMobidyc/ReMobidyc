Class {
	#name : #RMDGammaDistributionNode,
	#superclass : #RMDRandomNode,
	#instVars : [
		'scaleExpression',
		'shapeExpression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDGammaDistributionNode class >> shape: aRMDExpressionNode scale: anotherRMDExpressionNode [

	^ self new
		  shapeExpression: aRMDExpressionNode;
		  scaleExpression: anotherRMDExpressionNode;
		  yourself
]

{ #category : #comparing }
RMDGammaDistributionNode >> = anObject [
	^ self class = anObject class
		and: [ shapeExpression = anObject shapeExpression
				and: [ scaleExpression = anObject scaleExpression ] ]
]

{ #category : #private }
RMDGammaDistributionNode >> AhrensDieter: aNumber in: aRMDInterpreter [

	| e c1 |
	e := Float e.
	c1 := e / (aNumber + e).
	[ 
	| u1 u2 |
	u1 := aRMDInterpreter random.
	u2 := aRMDInterpreter random.
	u1 <= c1
		ifTrue: [ 
			| x |
			x := u1 / c1 ** aNumber reciprocal.
			u2 <= x negated exp ifTrue: [ ^ x ] ]
		ifFalse: [ 
			| x |
			x := (1.0 - u1 / (c1 * aNumber)) ln negated.
			u2 <= (x ** (aNumber - 1.0)) ifTrue: [ ^ x ] ] ] repeat
]

{ #category : #private }
RMDGammaDistributionNode >> MarsagliaTsang: aNumber in: aRMDInterpreter [

	| c1 c2 z v u |
	c1 := aNumber - (1.0 / 3.0).
	c2 := (9.0 * c1) sqrt reciprocal.
	[ 
	[ 
	z := self normalIn: aRMDInterpreter.
	c2 * z <= -1.0 ] whileTrue.
	v := c2 * z + 1.0 ** 3.0.
	u := aRMDInterpreter random.
	u < (1.0 - (0.0331 * (z squared squared))) ifTrue: [ ^ c1 * v ].
	u ln < (0.5 * z squared + (c1 * (1.0 - v + v ln))) ifTrue: [ 
		^ c1 * v ] ] repeat
]

{ #category : #enumerating }
RMDGammaDistributionNode >> childrenDo: aBlock [

	aBlock
		value: shapeExpression;
		value: scaleExpression
]

{ #category : #accessing }
RMDGammaDistributionNode >> gamma: aNumber in: aRMDInterpreter [

	^ aNumber <= 1.0
		  ifTrue: [ self AhrensDieter: aNumber in: aRMDInterpreter ]
		  ifFalse: [ self MarsagliaTsang: aNumber in: aRMDInterpreter ]
]

{ #category : #comparing }
RMDGammaDistributionNode >> hash [
	^ (self class hash bitXor: shapeExpression hash) bitXor: scaleExpression hash
]

{ #category : #testing }
RMDGammaDistributionNode >> isGammaDistributionNode [
	^ true
]

{ #category : #private }
RMDGammaDistributionNode >> normalIn: aRMDInterpreter [

	^ (aRMDInterpreter random ln * -2.0) sqrt
	  * (aRMDInterpreter random * Float pi * 2.0) cos
]

{ #category : #copying }
RMDGammaDistributionNode >> postCopy [

	shapeExpression := shapeExpression copy.
	scaleExpression := scaleExpression copy
]

{ #category : #accessing }
RMDGammaDistributionNode >> precedence [
	^ 10
]

{ #category : #printing }
RMDGammaDistributionNode >> printOn: aStream [
	aStream nextPutAll: 'gamma '.
	shapeExpression printOn: aStream.
	aStream nextPutAll: ' scale '.
	scaleExpression printOn: aStream
]

{ #category : #printing }
RMDGammaDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'gamma '.
	scaleExpression
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
RMDGammaDistributionNode >> replaceChildren: aDictionary [

	shapeExpression := shapeExpression copyReplace: aDictionary.
	scaleExpression := scaleExpression copyReplace: aDictionary
]

{ #category : #accessing }
RMDGammaDistributionNode >> scaleExpression [

	^ scaleExpression
]

{ #category : #accessing }
RMDGammaDistributionNode >> scaleExpression: aRMDExpressionNode [

	scaleExpression := aRMDExpressionNode
]

{ #category : #accessing }
RMDGammaDistributionNode >> shapeExpression [

	^ shapeExpression
]

{ #category : #accessing }
RMDGammaDistributionNode >> shapeExpression: aRMDExpressionNode [

	shapeExpression := aRMDExpressionNode
]
