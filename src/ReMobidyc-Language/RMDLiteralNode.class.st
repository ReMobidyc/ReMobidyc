Class {
	#name : #RMDLiteralNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'literal',
		'numeric',
		'unit'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDLiteralNode class >> literal: aString type: aRMDUnit [
	^ self new
		literal: aString;
		type: aRMDUnit;
		yourself
]

{ #category : #'instance creation' }
RMDLiteralNode class >> literal: aString unit: aRMDUnit [
	^ self new
		literal: aString;
		unit: aRMDUnit;
		yourself
]

{ #category : #comparing }
RMDLiteralNode >> = anObject [
	^ self class = anObject class and: [ literal = anObject literal ]
]

{ #category : #enumerating }
RMDLiteralNode >> childrenDo: aBlock [
	
]

{ #category : #private }
RMDLiteralNode >> computeNumeric [
	^ unit toSI: literal asNumber
]

{ #category : #comparing }
RMDLiteralNode >> hash [
	^ literal hash
]

{ #category : #testing }
RMDLiteralNode >> isLiteralNode [
	^ true
]

{ #category : #accessing }
RMDLiteralNode >> literal [
	^ literal
]

{ #category : #accessing }
RMDLiteralNode >> literal: aString [
	literal := aString
]

{ #category : #accessing }
RMDLiteralNode >> numeric [
	^ numeric ifNil: [ numeric := self computeNumeric ]
]

{ #category : #copying }
RMDLiteralNode >> postCopy [
	
]

{ #category : #accessing }
RMDLiteralNode >> precedence [
	^ 0
]

{ #category : #printing }
RMDLiteralNode >> printOn: aStream [
	aStream nextPutAll: self literal.
	unit hasDimension
		ifTrue: [ aStream nextPutAll: ' ['.
			unit printOn: aStream.
			aStream nextPut: $] ]
]

{ #category : #printing }
RMDLiteralNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: self literal.
	unit hasDimension
		ifTrue: [ aStream nextPutAll: ' ['.
			unit printOn: aStream.
			aStream nextPut: $] ].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDLiteralNode >> replaceChildren: aDictionary [
	aDictionary
		at: literal
		ifPresent: [ :node | 
			literal := node copy.
			numeric := nil ].
	aDictionary
		at: unit
		ifPresent: [ :node | 
			unit := node copy.
			numeric := nil ]
]

{ #category : #accessing }
RMDLiteralNode >> unit [
	^ unit
]

{ #category : #accessing }
RMDLiteralNode >> unit: aRMDUnit [
	unit := aRMDUnit
]
