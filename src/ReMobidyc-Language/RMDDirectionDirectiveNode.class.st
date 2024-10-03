Class {
	#name : 'RMDDirectionDirectiveNode',
	#superclass : 'RMDAgentDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDDirectionDirectiveNode class >> agent: anotherString [

	^ self new
		  agentIdentifier: anotherString;
		  yourself
]

{ #category : 'accessing' }
RMDDirectionDirectiveNode >> directiveName [

	^ 'direction'
]

{ #category : 'testing' }
RMDDirectionDirectiveNode >> isDirectionDirectiveNode [

	^ true
]

{ #category : 'printing' }
RMDDirectionDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'direction ';
		nextPutAll: agentIdentifier asString
]

{ #category : 'printing' }
RMDDirectionDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'direction ';
		nextPutAll: agentIdentifier asString.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
