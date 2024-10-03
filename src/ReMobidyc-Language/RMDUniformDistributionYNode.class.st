Class {
	#name : 'RMDUniformDistributionYNode',
	#superclass : 'RMDRandomNode',
	#classInstVars : [
		'current'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDUniformDistributionYNode class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : 'comparing' }
RMDUniformDistributionYNode >> = anObject [
	^ self class = anObject class
]

{ #category : 'enumerating' }
RMDUniformDistributionYNode >> childrenDo: aBlock [
	
]

{ #category : 'enumerating' }
RMDUniformDistributionYNode >> childrenTransform: aBlock [
	
]

{ #category : 'accessing' }
RMDUniformDistributionYNode >> distributionName [

	^ 'uniform'
]

{ #category : 'comparing' }
RMDUniformDistributionYNode >> hash [
	^ self class hash
]

{ #category : 'accessing' }
RMDUniformDistributionYNode >> parameter1Expression [

	^ 'south'
]

{ #category : 'accessing' }
RMDUniformDistributionYNode >> parameter2Expression [

	^ 'north'
]

{ #category : 'accessing' }
RMDUniformDistributionYNode >> parameterName [

	^ 'to'
]

{ #category : 'copying' }
RMDUniformDistributionYNode >> postCopy [
	
]

{ #category : 'accessing' }
RMDUniformDistributionYNode >> precedence [
	^ 1
]

{ #category : 'printing' }
RMDUniformDistributionYNode >> printOn: aStream [
	aStream nextPutAll: 'uniform south to north'
]

{ #category : 'printing' }
RMDUniformDistributionYNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'uniform south to north'.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDUniformDistributionYNode >> replaceChildren: aDictionary [
	
]
