Class {
	#name : #RMDLengthDirectiveNode,
	#superclass : #RMDSimulationDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #converting }
RMDLengthDirectiveNode >> asPresenter [

	^ RMDAtomicDirectivePresenter on: self
]

{ #category : #testing }
RMDLengthDirectiveNode >> isLengthDirectiveNode [
	^ true
]

{ #category : #printing }
RMDLengthDirectiveNode >> printOn: aStream [

	aStream nextPutAll: 'length of here'
]

{ #category : #printing }
RMDLengthDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'length of here'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
