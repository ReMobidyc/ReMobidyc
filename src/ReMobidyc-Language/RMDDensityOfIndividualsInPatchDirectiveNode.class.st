Class {
	#name : #RMDDensityOfIndividualsInPatchDirectiveNode,
	#superclass : #RMDIndividualsInPatchDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDensityOfIndividualsInPatchDirectiveNode >> isDensityOfIndividualsInPatchDirective [

	^ true
]

{ #category : #printing }
RMDDensityOfIndividualsInPatchDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'density of ';
		nextPutAll: animatName;
		nextPutAll: ' here'
]

{ #category : #printing }
RMDDensityOfIndividualsInPatchDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	self printOn: aStream.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
