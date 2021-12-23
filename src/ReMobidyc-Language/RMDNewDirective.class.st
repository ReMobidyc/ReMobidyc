Class {
	#name : #RMDNewDirective,
	#superclass : #RMDLifeDirectiveNode,
	#instVars : [
		'animatIdentifier',
		'quantity'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNewDirective class >> animatIdentifier: aString [

	^ self
		  animatIdentifier: aString
		  quantity: (RMDLiteralNode literal: '1' unit: RMDUnit noDimension)
]

{ #category : #'instance creation' }
RMDNewDirective class >> animatIdentifier: aString quantity: aRMDExpression [

	^ self new
		  animatIdentifier: aString;
		  quantity: aRMDExpression;
		  yourself
]

{ #category : #comparing }
RMDNewDirective >> = anObject [

	^ self class = anObject class and: [ 
		  animatIdentifier = anObject animatIdentifier and: [ 
			  quantity = anObject quantity ] ]
]

{ #category : #accessing }
RMDNewDirective >> animatIdentifier [

	^ animatIdentifier
]

{ #category : #accessing }
RMDNewDirective >> animatIdentifier: aString [

	animatIdentifier := aString = '-'
		                    ifTrue: [ nil ]
		                    ifFalse: [ aString ]
]

{ #category : #enumerating }
RMDNewDirective >> childrenDo: aBlock [

	aBlock value: quantity
]

{ #category : #comparing }
RMDNewDirective >> hash [

	^ (super hash bitXor: animatIdentifier hash) bitXor: quantity hash
]

{ #category : #testing }
RMDNewDirective >> isNewDirectiveNode [
	^ true
]

{ #category : #testing }
RMDNewDirective >> isPlaceholderNode [

	^ animatIdentifier isNil
]

{ #category : #copying }
RMDNewDirective >> postCopy [

	super postCopy.
	quantity := quantity copy
]

{ #category : #printing }
RMDNewDirective >> printOn: aStream [

	aStream nextPutAll: 'new '.
	animatIdentifier ifNil: [ aStream nextPut: $- ] ifNotNil: [ 
		quantity
			ifNil: [ aStream nextPut: $1 ]
			ifNotNil: [ quantity printOn: aStream ].
		aStream
			space;
			nextPutAll: animatIdentifier ]
]

{ #category : #printing }
RMDNewDirective >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'new '.
	animatIdentifier ifNil: [ aStream nextPut: $- ] ifNotNil: [ 
		quantity ifNil: [ aStream nextPut: $1 ] ifNotNil: [ 
			quantity
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ].
		aStream
			space;
			nextPutAll: animatIdentifier ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #accessing }
RMDNewDirective >> quantity [
	^ quantity
]

{ #category : #accessing }
RMDNewDirective >> quantity: anInteger [

	quantity := anInteger
]

{ #category : #rewriting }
RMDNewDirective >> replaceChildren: aDictionary [

	aDictionary
		at: animatIdentifier
		ifPresent: [ :node | animatIdentifier := node copy ].
	quantity ifNotNil: [ quantity := quantity copyReplace: aDictionary ]
]
