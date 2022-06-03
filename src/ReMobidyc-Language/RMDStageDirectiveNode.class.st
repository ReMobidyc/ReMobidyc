Class {
	#name : #RMDStageDirectiveNode,
	#superclass : #RMDLifeDirectiveNode,
	#instVars : [
		'animatIdentifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDStageDirectiveNode class >> animatIdentifier: aString [

	^ self new
		  animatIdentifier: aString;
		  yourself
]

{ #category : #comparing }
RMDStageDirectiveNode >> = anObject [

	^ self class = anObject class and: [ 
		  animatIdentifier = anObject animatIdentifier ]
]

{ #category : #accessing }
RMDStageDirectiveNode >> animatIdentifier [

	^ animatIdentifier
]

{ #category : #accessing }
RMDStageDirectiveNode >> animatIdentifier: aString [

	animatIdentifier := aString = '-'
		                    ifTrue: [ nil ]
		                    ifFalse: [ aString ]
]

{ #category : #comparing }
RMDStageDirectiveNode >> hash [

	^ super hash bitXor: animatIdentifier hash
]

{ #category : #testing }
RMDStageDirectiveNode >> isPlaceholderNode [

	^ animatIdentifier isNil
]

{ #category : #testing }
RMDStageDirectiveNode >> isStageDirectiveNode [
	^ true
]

{ #category : #printing }
RMDStageDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'stage ';
		nextPutAll: (animatIdentifier ifNil: [ '-' ])
]

{ #category : #printing }
RMDStageDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'stage ';
		nextPutAll: (animatIdentifier ifNil: [ '-' ]).
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDStageDirectiveNode >> replaceChildren: aDictionary [

	aDictionary
		at: animatIdentifier
		ifPresent: [ :node | animatIdentifier := node copy ]
]
