Class {
	#name : #RMDNewDirective,
	#superclass : #RMDLifeDirectiveNode,
	#instVars : [
		'animatIdentifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNewDirective class >> animatIdentifier: aString [

	^ self new
		  animatIdentifier: aString;
		  yourself
]

{ #category : #comparing }
RMDNewDirective >> = anObject [

	^ self class = anObject class and: [ 
		  animatIdentifier = anObject animatIdentifier ]
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

{ #category : #comparing }
RMDNewDirective >> hash [

	^ super hash bitXor: animatIdentifier hash
]

{ #category : #testing }
RMDNewDirective >> isNewDirectiveNode [
	^ true
]

{ #category : #testing }
RMDNewDirective >> isPlaceholderNode [

	^ animatIdentifier isNil
]

{ #category : #printing }
RMDNewDirective >> printOn: aStream [

	aStream
		nextPutAll: 'new ';
		nextPutAll: (animatIdentifier ifNil: [ '-' ])
]

{ #category : #printing }
RMDNewDirective >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'new ';
		nextPutAll: (animatIdentifier ifNil: [ '-' ]).
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDNewDirective >> replaceChildren: aDictionary [

	aDictionary
		at: animatIdentifier
		ifPresent: [ :node | animatIdentifier := node copy ]
]
