Class {
	#name : 'RMDDeltaTimeDirectiveNode',
	#superclass : 'RMDSimulationDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'converting' }
RMDDeltaTimeDirectiveNode >> asPresenter [

	^ RMDAtomicDirectivePresenter on: self
]

{ #category : 'testing' }
RMDDeltaTimeDirectiveNode >> isDeltaTimeDirectiveNode [
	^ true
]

{ #category : 'printing' }
RMDDeltaTimeDirectiveNode >> printOn: aStream [

	aStream nextPutAll: 'Δtime'
]

{ #category : 'printing' }
RMDDeltaTimeDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'Δtime'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
