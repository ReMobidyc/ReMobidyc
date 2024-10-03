Class {
	#name : 'RMDDensityOfIndividualsInRadiusDirectiveNode',
	#superclass : 'RMDIndividualsInRadiusDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDDensityOfIndividualsInRadiusDirectiveNode >> directiveName [

	^ 'density of'
]

{ #category : 'testing' }
RMDDensityOfIndividualsInRadiusDirectiveNode >> isDensityOfIndividualsInRadiusDirective [

	^ true
]

{ #category : 'printing' }
RMDDensityOfIndividualsInRadiusDirectiveNode >> printOn: aStream [

	aStream
		nextPutAll: 'density of ';
		nextPutAll: animatName.
	aStream nextPutAll: ' in '.
	radius printOn: aStream.
	aStream nextPutAll: ' radius'
]

{ #category : 'printing' }
RMDDensityOfIndividualsInRadiusDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'density of ';
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
