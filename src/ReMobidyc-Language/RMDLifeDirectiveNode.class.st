Class {
	#name : #RMDLifeDirectiveNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDLifeDirectiveNode class >> isAbstract [

	^ self == RMDLifeDirectiveNode
]

{ #category : #comparing }
RMDLifeDirectiveNode >> = anObject [
	^ self class = anObject class
]

{ #category : #enumerating }
RMDLifeDirectiveNode >> childrenDo: aBlock [

]

{ #category : #enumerating }
RMDLifeDirectiveNode >> childrenTransform: aBlock [

]

{ #category : #testing }
RMDLifeDirectiveNode >> hasNewAgents [

	^ false
]

{ #category : #comparing }
RMDLifeDirectiveNode >> hash [
	^ self class hash
]

{ #category : #testing }
RMDLifeDirectiveNode >> isLifeDirectiveNode [
	^ true
]

{ #category : #copying }
RMDLifeDirectiveNode >> postCopy [
	
]

{ #category : #rewriting }
RMDLifeDirectiveNode >> replaceChildren: aDictionary [
	
]
