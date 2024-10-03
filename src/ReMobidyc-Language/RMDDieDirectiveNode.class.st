Class {
	#name : 'RMDDieDirectiveNode',
	#superclass : 'RMDLifeDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDDieDirectiveNode >> isDieDirectiveNode [
	^ true
]

{ #category : 'printing' }
RMDDieDirectiveNode >> printOn: aStream [

	aStream nextPutAll: 'die'
]

{ #category : 'printing' }
RMDDieDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'die'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
