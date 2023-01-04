Class {
	#name : #RMDDirectionOfGradientDirectiveNode,
	#superclass : #RMDPatchDirectiveNode,
	#instVars : [
		'patchAttributeVariable'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDDirectionOfGradientDirectiveNode class >> variable: aRMDAttributeVariableNodeOrRMDPlaceholderNode [

	^ self new
		  patchAttributeVariable:
			  aRMDAttributeVariableNodeOrRMDPlaceholderNode;
		  yourself
]

{ #category : #comparing }
RMDDirectionOfGradientDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  patchAttributeVariable = anObject patchAttributeVariable ]
]

{ #category : #enumerating }
RMDDirectionOfGradientDirectiveNode >> childrenDo: aBlock [

	aBlock value: patchAttributeVariable
]

{ #category : #comparing }
RMDDirectionOfGradientDirectiveNode >> hash [
	^ self class hash bitXor: patchAttributeVariable hash
]

{ #category : #testing }
RMDDirectionOfGradientDirectiveNode >> isDirectionOfGradientDirectiveNode [

	^ true
]

{ #category : #accessing }
RMDDirectionOfGradientDirectiveNode >> patchAttributeVariable [

	^ patchAttributeVariable
]

{ #category : #accessing }
RMDDirectionOfGradientDirectiveNode >> patchAttributeVariable: aRMDAttributeVariableNodeOrRMDPlaceholderNode [

	patchAttributeVariable := aRMDAttributeVariableNodeOrRMDPlaceholderNode
]

{ #category : #copying }
RMDDirectionOfGradientDirectiveNode >> postCopy [

	patchAttributeVariable := patchAttributeVariable copy
]

{ #category : #printing }
RMDDirectionOfGradientDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'direction neighbor''s ';
		nextPutAll: patchAttributeVariable identifier
]

{ #category : #printing }
RMDDirectionOfGradientDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'direction neighbor''s ';
		nextPutAll: patchAttributeVariable identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDDirectionOfGradientDirectiveNode >> replaceChildren: aDictionary [
	aDictionary
		at: patchAttributeVariable 
		ifPresent: [ :node | patchAttributeVariable := node copy ]
]
