Class {
	#name : #RMDAbstractAssignableAttributeVariableNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'attributeVariable'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAbstractAssignableAttributeVariableNode class >> attributeVariable: aRMDAttributeVariableNode [

	^ self new
		  attributeVariable: aRMDAttributeVariableNode;
		  yourself
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode class >> classForOperator: aString [

	aString = self deltaOperator ifTrue: [
		^ RMDAssignableDeltaAttributeVariableNode ].
	aString = self differentialOperator ifTrue: [
		^ RMDAssignableDifferentialAttributeVariableNode ].
	^ RMDAssignableAttributeVariableNode
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode class >> deltaOperator [

	^ 'Δ'
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode class >> differentialOperator [

	^ 'd/dt '
]

{ #category : #'instance creation' }
RMDAbstractAssignableAttributeVariableNode class >> identifier: aString agent: anotherString [
	^ self new
		attributeVariable: (RMDAttributeVariableNode identifier: aString agent: anotherString);
		yourself
]

{ #category : #'instance creation' }
RMDAbstractAssignableAttributeVariableNode class >> operator: aString attributeVariable: aRMDAttributeVariableNode [

	^ (self classForOperator: aString) attributeVariable:
		  aRMDAttributeVariableNode
]

{ #category : #comparing }
RMDAbstractAssignableAttributeVariableNode >> = anObject [
	^ self class = anObject class
		and: [ attributeVariable = anObject attributeVariable ]
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode >> agent [
	^ attributeVariable agent
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode >> agent: aString [

	self attributeVariable:
		(RMDAttributeVariableNode identifier: self identifier agent: aString)
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode >> attributeVariable [
	^ attributeVariable
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode >> attributeVariable: aRMDAttributeVariableNode [
	attributeVariable := aRMDAttributeVariableNode
]

{ #category : #enumerating }
RMDAbstractAssignableAttributeVariableNode >> childrenDo: aBlock [
	aBlock value: attributeVariable
]

{ #category : #enumerating }
RMDAbstractAssignableAttributeVariableNode >> childrenTransform: aBlock [

	attributeVariable := aBlock value: attributeVariable
]

{ #category : #comparing }
RMDAbstractAssignableAttributeVariableNode >> hash [
	^ self class hash bitXor: attributeVariable hash
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode >> identifier [
	^ attributeVariable identifier
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode >> identifier: aString [

	attributeVariable identifier: aString
]

{ #category : #private }
RMDAbstractAssignableAttributeVariableNode >> insertTrace [
]

{ #category : #accessing }
RMDAbstractAssignableAttributeVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #converting }
RMDAbstractAssignableAttributeVariableNode >> operator: aString [

	^ self class operator: aString attributeVariable: attributeVariable
]

{ #category : #copying }
RMDAbstractAssignableAttributeVariableNode >> postCopy [
	
]

{ #category : #printing }
RMDAbstractAssignableAttributeVariableNode >> printOn: aStream [

	aStream
		nextPutAll: attributeVariable prefix;
		space;
		nextPutAll: self operator;
		nextPutAll: self identifier
]

{ #category : #printing }
RMDAbstractAssignableAttributeVariableNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: attributeVariable prefix;
		space;
		nextPutAll: self operator;
		nextPutAll: self identifier.
	((aCollectionOfRMDSyntaxNode includes: self) or: [ 
		 aCollectionOfRMDSyntaxNode includes: attributeVariable ]) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAbstractAssignableAttributeVariableNode >> replaceChildren: aDictionary [
	attributeVariable := attributeVariable copyReplace: aDictionary
]
