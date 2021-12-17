Class {
	#name : #RMDTerminalDirective,
	#superclass : #RMDLifeDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #printing }
RMDTerminalDirective >> printOn: aStream [
	^ 'die'
]

{ #category : #printing }
RMDTerminalDirective >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'die'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
