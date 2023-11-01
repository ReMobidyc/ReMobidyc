Class {
	#name : #RMDAreaDirectiveNode,
	#superclass : #RMDSimulationDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDAreaDirectiveNode >> isAreaDirectiveNode [
	^ true
]

{ #category : #printing }
RMDAreaDirectiveNode >> printOn: aStream [

	aStream nextPutAll: 'area of here'
]

{ #category : #printing }
RMDAreaDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'area of here'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
