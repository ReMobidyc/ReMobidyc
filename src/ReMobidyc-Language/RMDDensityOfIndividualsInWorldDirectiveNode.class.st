Class {
	#name : #RMDDensityOfIndividualsInWorldDirectiveNode,
	#superclass : #RMDIndividualsInWorldDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDensityOfIndividualsInWorldDirectiveNode >> isDensityOfIndividualsInWorldDirective [

	^ true
]

{ #category : #printing }
RMDDensityOfIndividualsInWorldDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'density of ';
		nextPutAll: animatName;
		nextPutAll: ' in world'
]

{ #category : #printing }
RMDDensityOfIndividualsInWorldDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	self printOn: aStream.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
