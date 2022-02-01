Class {
	#name : #RMDCellDirectiveNode,
	#superclass : #RMDDirectiveNode,
	#instVars : [
		'cellAttributeVariable'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDCellDirectiveNode class >> directive: aString identifier: anotherString [
	^ self new
		directive: aString;
		cellAttributeVariable: (RMDAttributeVariableNode identifier: anotherString agent: 'here');
		yourself
]

{ #category : #comparing }
RMDCellDirectiveNode >> = anObject [
	^ super = anObject
		and: [ cellAttributeVariable = anObject cellAttributeVariable ]
]

{ #category : #accessing }
RMDCellDirectiveNode >> cellAttributeVariable [
	^ cellAttributeVariable
]

{ #category : #accessing }
RMDCellDirectiveNode >> cellAttributeVariable: aRMDAttributeVariableNode [
	cellAttributeVariable := aRMDAttributeVariableNode
]

{ #category : #enumerating }
RMDCellDirectiveNode >> childrenDo: aBlock [
	aBlock value: cellAttributeVariable
]

{ #category : #comparing }
RMDCellDirectiveNode >> hash [
	^ super hash bitXor: cellAttributeVariable hash
]

{ #category : #testing }
RMDCellDirectiveNode >> isCellDirectiveNode [
	^ true
]

{ #category : #copying }
RMDCellDirectiveNode >> postCopy [
	cellAttributeVariable := cellAttributeVariable copy
]

{ #category : #printing }
RMDCellDirectiveNode >> printOn: aStream [
	aStream
		nextPutAll: directive;
		nextPutAll: ' neighbor''s ';
		nextPutAll: cellAttributeVariable identifier
]

{ #category : #printing }
RMDCellDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: directive;
		nextPutAll: ' neighbor''s ';
		nextPutAll: cellAttributeVariable identifier.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
