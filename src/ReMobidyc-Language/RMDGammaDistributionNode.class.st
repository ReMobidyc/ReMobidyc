Class {
	#name : #RMDGammaDistributionNode,
	#superclass : #RMDRandomNode,
	#instVars : [
		'shapeExpression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDGammaDistributionNode class >> isAbstract [

	^ self == RMDGammaDistributionNode
]

{ #category : #'instance creation' }
RMDGammaDistributionNode class >> shape: aRMDExpressionNode mean: anotherRMDExpressionNode [

	^ self withMeanClass new
		  shapeExpression: aRMDExpressionNode;
		  meanExpression: anotherRMDExpressionNode;
		  yourself
]

{ #category : #'instance creation' }
RMDGammaDistributionNode class >> shape: aRMDExpressionNode rate: anotherRMDExpressionNode [

	^ self withRateClass new
		  shapeExpression: aRMDExpressionNode;
		  rateExpression: anotherRMDExpressionNode;
		  yourself
]

{ #category : #'instance creation' }
RMDGammaDistributionNode class >> shape: aRMDExpressionNode scale: anotherRMDExpressionNode [

	^ self withScaleClass new
		  shapeExpression: aRMDExpressionNode;
		  scaleExpression: anotherRMDExpressionNode;
		  yourself
]

{ #category : #'class access' }
RMDGammaDistributionNode class >> withMeanClass [

	^ RMDGammaMeanDistributionNode
]

{ #category : #'class access' }
RMDGammaDistributionNode class >> withRateClass [

	^ RMDGammaRateDistributionNode
]

{ #category : #'class access' }
RMDGammaDistributionNode class >> withScaleClass [

	^ RMDGammaScaleDistributionNode
]

{ #category : #comparing }
RMDGammaDistributionNode >> = anObject [

	^ self class = anObject class and: [ 
		  shapeExpression = anObject shapeExpression ]
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

	aBlock value: shapeExpression
]

{ #category : #accessing }
RMDGammaDistributionNode >> gamma: aNumber in: aRMDInterpreter [

	^ aNumber <= 1.0
		  ifTrue: [ self AhrensDieter: aNumber in: aRMDInterpreter ]
		  ifFalse: [ self MarsagliaTsang: aNumber in: aRMDInterpreter ]
]

{ #category : #comparing }
RMDGammaDistributionNode >> hash [

	^ self class hash bitXor: shapeExpression hash
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

	shapeExpression := shapeExpression copy
]

{ #category : #accessing }
RMDGammaDistributionNode >> precedence [
	^ 10
]

{ #category : #rewriting }
RMDGammaDistributionNode >> replaceChildren: aDictionary [

	shapeExpression := shapeExpression copyReplace: aDictionary
]

{ #category : #accessing }
RMDGammaDistributionNode >> shapeExpression [

	^ shapeExpression
]

{ #category : #accessing }
RMDGammaDistributionNode >> shapeExpression: aRMDExpressionNode [

	shapeExpression := aRMDExpressionNode
]
