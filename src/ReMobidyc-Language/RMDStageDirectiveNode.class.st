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

{ #category : #accessing }
RMDStageDirectiveNode >> animatIdentifier [

	^ animatIdentifier
]

{ #category : #accessing }
RMDStageDirectiveNode >> animatIdentifier: aString [

	animatIdentifier := aString
]

{ #category : #testing }
RMDStageDirectiveNode >> isStageDirectiveNode [
	^ true
]

{ #category : #printing }
RMDStageDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'stage ';
		nextPutAll: animatIdentifier
]

{ #category : #printing }
RMDStageDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'stage ';
		nextPutAll: animatIdentifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
