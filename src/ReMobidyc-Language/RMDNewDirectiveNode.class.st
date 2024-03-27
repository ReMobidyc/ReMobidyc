Class {
	#name : #RMDNewDirectiveNode,
	#superclass : #RMDLifeDirectiveNode,
	#instVars : [
		'animatIdentifier',
		'quantity'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNewDirectiveNode class >> animatIdentifier: aString [

	^ self
		  animatIdentifier: aString
		  quantity: (RMDLiteralNode literal: '1' unit: RMDUnit noDimension)
]

{ #category : #'instance creation' }
RMDNewDirectiveNode class >> animatIdentifier: aString quantity: aRMDExpression [

	^ self new
		  animatIdentifier: aString;
		  quantity: aRMDExpression;
		  yourself
]

{ #category : #comparing }
RMDNewDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  animatIdentifier = anObject animatIdentifier and: [ 
			  quantity = anObject quantity ] ]
]

{ #category : #accessing }
RMDNewDirectiveNode >> animatIdentifier [

	^ animatIdentifier
]

{ #category : #accessing }
RMDNewDirectiveNode >> animatIdentifier: aString [

	animatIdentifier := aString = '-'
		                    ifTrue: [ nil ]
		                    ifFalse: [ aString ]
]

{ #category : #enumerating }
RMDNewDirectiveNode >> childrenDo: aBlock [

	quantity ifNotNil: [ aBlock value: quantity ]
]

{ #category : #enumerating }
RMDNewDirectiveNode >> childrenTransform: aBlock [

	quantity ifNotNil: [ quantity := aBlock value: quantity ]
]

{ #category : #testing }
RMDNewDirectiveNode >> hasNewAgents [

	^ true
]

{ #category : #comparing }
RMDNewDirectiveNode >> hash [

	^ (super hash bitXor: animatIdentifier hash) bitXor: quantity hash
]

{ #category : #testing }
RMDNewDirectiveNode >> isNewDirectiveNode [
	^ true
]

{ #category : #testing }
RMDNewDirectiveNode >> isPlaceholderNode [

	^ animatIdentifier isNil
]

{ #category : #copying }
RMDNewDirectiveNode >> postCopy [

	super postCopy.
	quantity := quantity copy
]

{ #category : #printing }
RMDNewDirectiveNode >> printOn: aStream [

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
RMDNewDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

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
RMDNewDirectiveNode >> quantity [
	^ quantity
]

{ #category : #accessing }
RMDNewDirectiveNode >> quantity: aRMDExpression [

	quantity := aRMDExpression
]

{ #category : #rewriting }
RMDNewDirectiveNode >> renameAnimat: aString to: anotherString [

	animatIdentifier = aString ifTrue: [ 
		animatIdentifier := anotherString ].
	super renameAnimat: aString to: anotherString
]

{ #category : #rewriting }
RMDNewDirectiveNode >> replaceChildren: aDictionary [

	aDictionary
		at: animatIdentifier
		ifPresent: [ :node | animatIdentifier := node copy ].
	quantity ifNotNil: [ quantity := quantity copyReplace: aDictionary ]
]
