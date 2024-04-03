Class {
	#name : #RMDNumberOfIndividualsInPatchDirectiveNode,
	#superclass : #RMDIndividualsInPatchDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDNumberOfIndividualsInPatchDirectiveNode >> directiveName [

	^ 'number of'
]

{ #category : #testing }
RMDNumberOfIndividualsInPatchDirectiveNode >> isNumberOfIndividualsInPatchDirective [

	^ true
]

{ #category : #printing }
RMDNumberOfIndividualsInPatchDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'number of ';
		nextPutAll: animatName;
		nextPutAll: ' here'
]

{ #category : #printing }
RMDNumberOfIndividualsInPatchDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	self printOn: aStream.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
