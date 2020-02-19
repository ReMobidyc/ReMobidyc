Class {
	#name : #RMDPropertyDeclarationNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'unit'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyDeclarationNode class >> identifier: aString unit: aRMDUnit [
	^ self new
		identifier: aString;
		unit: aRMDUnit;
		yourself
]

{ #category : #comparing }
RMDPropertyDeclarationNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier
				and: [ unit = anObject unit ] ]
]

{ #category : #enumerating }
RMDPropertyDeclarationNode >> childrenDo: aBlock [

]

{ #category : #comparing }
RMDPropertyDeclarationNode >> hash [
	^ (self class hash bitXor: identifier hash) bitXor: unit hash
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDPropertyDeclarationNode >> isPropertyDeclarationNode [
	^ true
]

{ #category : #printing }
RMDPropertyDeclarationNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' ['.
	unit printOn: aStream.
	aStream nextPut: $]
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> unit [
	^ unit
]

{ #category : #accessing }
RMDPropertyDeclarationNode >> unit: anRMDUnit [
	unit := anRMDUnit
]
