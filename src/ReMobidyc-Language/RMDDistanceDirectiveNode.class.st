Class {
	#name : 'RMDDistanceDirectiveNode',
	#superclass : 'RMDAgentDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDDistanceDirectiveNode class >> agent: anotherString [

	^ self new
		  agentIdentifier: anotherString;
		  yourself
]

{ #category : 'accessing' }
RMDDistanceDirectiveNode >> directiveName [

	^ 'distance'
]

{ #category : 'testing' }
RMDDistanceDirectiveNode >> isDistanceDirectiveNode [

	^ true
]

{ #category : 'printing' }
RMDDistanceDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'distance ';
		nextPutAll: agentIdentifier asString
]

{ #category : 'printing' }
RMDDistanceDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'distance ';
		nextPutAll: agentIdentifier asString.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
