Class {
	#name : #RMDNumberOfIndividualsInRadiusDirectiveNode,
	#superclass : #RMDIndividualsInRadiusDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDNumberOfIndividualsInRadiusDirectiveNode >> directiveName [

	^ 'number of'
]

{ #category : #testing }
RMDNumberOfIndividualsInRadiusDirectiveNode >> isNumberOfIndividualsInRadiusDirective [

	^ true
]

{ #category : #printing }
RMDNumberOfIndividualsInRadiusDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'number of ';
		nextPutAll: animatName.
	aStream nextPutAll: ' in '.
	radius printOn: aStream.
	aStream nextPutAll: ' radius'
]

{ #category : #printing }
RMDNumberOfIndividualsInRadiusDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'number of ';
		nextPutAll: animatName.
	aStream nextPutAll: ' in '.
	radius
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' radius'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [
		aCollection add: (start to: aStream position) ]
]
