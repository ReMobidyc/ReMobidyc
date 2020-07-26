Class {
	#name : #RMDCellDirectiveNode,
	#superclass : #RMDDirectiveNode,
	#instVars : [
		'cellPropertyVariable'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDCellDirectiveNode class >> directive: aString identifier: anotherString [
	^ self new
		directive: aString;
		cellPropertyVariable: (RMDPropertyVariableNode identifier: anotherString agent: 'here');
		yourself
]

{ #category : #comparing }
RMDCellDirectiveNode >> = anObject [
	^ super = anObject
		and: [ cellPropertyVariable = anObject cellPropertyVariable ]
]

{ #category : #accessing }
RMDCellDirectiveNode >> cellPropertyVariable [
	^ cellPropertyVariable
]

{ #category : #accessing }
RMDCellDirectiveNode >> cellPropertyVariable: aRMDPropertyVariableNode [
	cellPropertyVariable := aRMDPropertyVariableNode
]

{ #category : #enumerating }
RMDCellDirectiveNode >> childrenDo: aBlock [
	aBlock value: cellPropertyVariable
]

{ #category : #comparing }
RMDCellDirectiveNode >> hash [
	^ super hash bitXor: cellPropertyVariable hash
]

{ #category : #testing }
RMDCellDirectiveNode >> isCellDirectiveNode [
	^ true
]

{ #category : #copying }
RMDCellDirectiveNode >> postCopy [
	cellPropertyVariable := cellPropertyVariable copy
]

{ #category : #printing }
RMDCellDirectiveNode >> printOn: aStream [
	aStream
		nextPutAll: directive;
		nextPutAll: ' neighbor''s ';
		nextPutAll: cellPropertyVariable identifier
]
