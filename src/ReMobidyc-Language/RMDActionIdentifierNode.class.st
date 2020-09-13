Class {
	#name : #RMDActionIdentifierNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'shortName'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDActionIdentifierNode >> = anObject [
	^ self class = anObject class and: [ shortName = anObject shortName ]
]

{ #category : #enumerating }
RMDActionIdentifierNode >> childrenDo: aBlock [
]

{ #category : #comparing }
RMDActionIdentifierNode >> hash [
	^ self class hash bitXor: shortName hash
]

{ #category : #testing }
RMDActionIdentifierNode >> isActionIdentifierNode [
	^ true
]

{ #category : #testing }
RMDActionIdentifierNode >> isReadOnly [ 
	^ self subclassResponsibility 
]

{ #category : #copying }
RMDActionIdentifierNode >> postCopy [

]

{ #category : #rewriting }
RMDActionIdentifierNode >> replaceChildren: aDictionary [
	aDictionary
		at: shortName
		ifPresent: [ :node | shortName := node copy ]
]

{ #category : #accessing }
RMDActionIdentifierNode >> shortName [
	^ shortName
]

{ #category : #accessing }
RMDActionIdentifierNode >> shortName: aString [
	shortName := aString
]
