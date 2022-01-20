Class {
	#name : #RMDKillDirectiveNode,
	#superclass : #RMDLifeDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDKillDirectiveNode >> isKillDirectiveNode [
	^ true
]

{ #category : #printing }
RMDKillDirectiveNode >> printOn: aStream [

	aStream nextPutAll: 'kill'
]

{ #category : #printing }
RMDKillDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'kill'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #'as yet unclassified' }
RMDKillDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context objectDefinition notNil
]
