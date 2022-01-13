Class {
	#name : #RMDKillDirective,
	#superclass : #RMDLifeDirectiveNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDKillDirective >> isKillDirectiveNode [
	^ true
]

{ #category : #printing }
RMDKillDirective >> printOn: aStream [

	aStream nextPutAll: 'kill'
]

{ #category : #printing }
RMDKillDirective >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'kill'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #'as yet unclassified' }
RMDKillDirective >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context objectDefinition notNil
]
