Class {
	#name : #RMDPatchDirectiveNode,
	#superclass : #RMDDirectiveNode,
	#instVars : [
		'patchAttributeVariable'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPatchDirectiveNode class >> directive: aString identifier: anotherString [
	^ self new
		directive: aString;
		patchAttributeVariable: (RMDAttributeVariableNode identifier: anotherString agent: 'here');
		yourself
]

{ #category : #comparing }
RMDPatchDirectiveNode >> = anObject [
	^ super = anObject
		and: [ patchAttributeVariable = anObject patchAttributeVariable ]
]

{ #category : #enumerating }
RMDPatchDirectiveNode >> childrenDo: aBlock [
	aBlock value: patchAttributeVariable
]

{ #category : #comparing }
RMDPatchDirectiveNode >> hash [
	^ super hash bitXor: patchAttributeVariable hash
]

{ #category : #testing }
RMDPatchDirectiveNode >> isPatchDirectiveNode [
	^ true
]

{ #category : #accessing }
RMDPatchDirectiveNode >> patchAttributeVariable [
	^ patchAttributeVariable
]

{ #category : #accessing }
RMDPatchDirectiveNode >> patchAttributeVariable: aRMDAttributeVariableNode [
	patchAttributeVariable := aRMDAttributeVariableNode
]

{ #category : #copying }
RMDPatchDirectiveNode >> postCopy [
	patchAttributeVariable := patchAttributeVariable copy
]

{ #category : #printing }
RMDPatchDirectiveNode >> printOn: aStream [
	aStream
		nextPutAll: directive;
		nextPutAll: ' neighbor''s ';
		nextPutAll: patchAttributeVariable identifier
]

{ #category : #printing }
RMDPatchDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: directive;
		nextPutAll: ' neighbor''s ';
		nextPutAll: patchAttributeVariable identifier.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
