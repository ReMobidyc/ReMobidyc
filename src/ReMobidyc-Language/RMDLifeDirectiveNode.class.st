Class {
	#name : #RMDLifeDirectiveNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDLifeDirectiveNode >> = anObject [
	^ self class = anObject class
]

{ #category : #enumerating }
RMDLifeDirectiveNode >> childrenDo: aBlock [

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
