Class {
	#name : 'RMDAbstractVariableNode',
	#superclass : 'RMDExpressionNode',
	#instVars : [
		'identifier'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDAbstractVariableNode class >> isAbstract [

	^ self == RMDAbstractVariableNode
]

{ #category : 'comparing' }
RMDAbstractVariableNode >> = anObject [
	^ self class = anObject class and: [ identifier = anObject identifier ]
]

{ #category : 'accessing' }
RMDAbstractVariableNode >> agent [
	^ nil
]

{ #category : 'comparing' }
RMDAbstractVariableNode >> hash [
	^ self class hash bitXor: identifier hash
]

{ #category : 'accessing' }
RMDAbstractVariableNode >> identifier [
	^ identifier
]

{ #category : 'accessing' }
RMDAbstractVariableNode >> identifier: aString [
	identifier := aString
]

{ #category : 'testing' }
RMDAbstractVariableNode >> isReferenceNode [

	^ true
]

{ #category : 'copying' }
RMDAbstractVariableNode >> postCopy [
	
]

{ #category : 'rewriting' }
RMDAbstractVariableNode >> replaceChildren: aDictionary [
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]
