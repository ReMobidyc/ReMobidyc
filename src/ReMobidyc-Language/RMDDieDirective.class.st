Class {
	#name : #RMDDieDirective,
	#superclass : #RMDLifeDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDieDirective >> isDieDirectiveNode [
	^ true
]

{ #category : #printing }
RMDDieDirective >> printOn: aStream [

	aStream nextPutAll: 'die'
]

{ #category : #printing }
RMDDieDirective >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'die'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
