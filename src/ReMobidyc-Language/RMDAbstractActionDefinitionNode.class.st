Class {
	#name : #RMDAbstractActionDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'object'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDAbstractActionDefinitionNode >> = anObject [

	^ self class = anObject class and: [ 
		  identifier = anObject identifier and: [ object = anObject object ] ]
]

{ #category : #testing }
RMDAbstractActionDefinitionNode >> hasObject [
	^ object notNil
]

{ #category : #comparing }
RMDAbstractActionDefinitionNode >> hash [

	^ identifier hash bitXor: object hash
]

{ #category : #accessing }
RMDAbstractActionDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAbstractActionDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #accessing }
RMDAbstractActionDefinitionNode >> object [
	^ object
]

{ #category : #accessing }
RMDAbstractActionDefinitionNode >> object: aString [
	object := aString
]

{ #category : #rewriting }
RMDAbstractActionDefinitionNode >> replaceChildren: aDictionary [

	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ].
	aDictionary at: object ifPresent: [ :node | object := node copy ]
]
