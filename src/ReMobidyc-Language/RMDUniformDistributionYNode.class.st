Class {
	#name : #RMDUniformDistributionYNode,
	#superclass : #RMDRandomNode,
	#classInstVars : [
		'current'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDUniformDistributionYNode class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #comparing }
RMDUniformDistributionYNode >> = anObject [
	^ self class = anObject class
]

{ #category : #enumerating }
RMDUniformDistributionYNode >> childrenDo: aBlock [
	
]

{ #category : #comparing }
RMDUniformDistributionYNode >> hash [
	^ self class hash
]

{ #category : #copying }
RMDUniformDistributionYNode >> postCopy [
	
]

{ #category : #accessing }
RMDUniformDistributionYNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDUniformDistributionYNode >> printOn: aStream [
	aStream nextPutAll: 'uniform south to north'
]

{ #category : #rewriting }
RMDUniformDistributionYNode >> replaceChildren: aDictionary [
	
]
