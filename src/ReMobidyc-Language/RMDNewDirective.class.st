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

{ #category : #accessing }
RMDNewDirective >> animatIdentifier [

	^ animatIdentifier
]

{ #category : #accessing }
RMDNewDirective >> animatIdentifier: aString [

	animatIdentifier := aString
]

{ #category : #printing }
RMDNewDirective >> printOn: aStream [

	aStream
		nextPutAll: 'new ';
		nextPutAll: animatIdentifier
]

{ #category : #printing }
RMDNewDirective >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'new ';
		nextPutAll: animatIdentifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
