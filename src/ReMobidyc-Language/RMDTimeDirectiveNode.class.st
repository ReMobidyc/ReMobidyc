Class {
	#name : 'RMDTimeDirectiveNode',
	#superclass : 'RMDSimulationDirectiveNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'converting' }
RMDTimeDirectiveNode >> asPresenter [

	^ RMDAtomicDirectivePresenter on: self
]

{ #category : 'testing' }
RMDTimeDirectiveNode >> isTimeDirectiveNode [

	^ true
]

{ #category : 'printing' }
RMDTimeDirectiveNode >> printOn: aStream [

	aStream nextPutAll: 'time'
]

{ #category : 'printing' }
RMDTimeDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'time'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
