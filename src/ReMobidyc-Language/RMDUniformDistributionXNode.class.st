Class {
	#name : #RMDUniformDistributionXNode,
	#superclass : #RMDRandomNode,
	#classInstVars : [
		'current'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'sole instance' }
RMDUniformDistributionXNode class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #comparing }
RMDUniformDistributionXNode >> = anObject [
	^ self class = anObject class
]

{ #category : #enumerating }
RMDUniformDistributionXNode >> childrenDo: aBlock [
	
]

{ #category : #comparing }
RMDUniformDistributionXNode >> hash [
	^ self class hash
]

{ #category : #copying }
RMDUniformDistributionXNode >> postCopy [
	
]

{ #category : #accessing }
RMDUniformDistributionXNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDUniformDistributionXNode >> printOn: aStream [
	aStream nextPutAll: 'uniform west to east'
]

{ #category : #printing }
RMDUniformDistributionXNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'uniform west to east'.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDUniformDistributionXNode >> replaceChildren: aDictionary [
	
]
