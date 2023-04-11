Class {
	#name : #RMDBinaryCombinatorNode,
	#superclass : #RMDConditionNode,
	#instVars : [
		'conditions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDBinaryCombinatorNode class >> conditions: anArrayOfRMDConditionNode [
	^ self new
		conditions: anArrayOfRMDConditionNode;
		yourself
]

{ #category : #testing }
RMDBinaryCombinatorNode class >> isAbstract [

	^ self == RMDBinaryCombinatorNode
]

{ #category : #comparing }
RMDBinaryCombinatorNode >> = anObject [
	^ self class = anObject class
		and: [ conditions = anObject conditions ]
]

{ #category : #enumerating }
RMDBinaryCombinatorNode >> childrenDo: aBlock [
	conditions do: aBlock
]

{ #category : #accessing }
RMDBinaryCombinatorNode >> conditions [
	^ conditions
]

{ #category : #accessing }
RMDBinaryCombinatorNode >> conditions: anArrayOfRMDConditionNode [
	conditions := anArrayOfRMDConditionNode
]

{ #category : #comparing }
RMDBinaryCombinatorNode >> hash [
	^ self class hash bitXor: conditions hash
]

{ #category : #accessing }
RMDBinaryCombinatorNode >> operator [
	^ self subclassResponsibility
]

{ #category : #copying }
RMDBinaryCombinatorNode >> postCopy [
	conditions := conditions collect: #copy
]

{ #category : #accessing }
RMDBinaryCombinatorNode >> precedence [
	^ 2
]

{ #category : #printing }
RMDBinaryCombinatorNode >> printOn: aStream [
	conditions
		do: [ :cond | 
			self precedence <= cond precedence
				ifTrue: [ aStream nextPut: $( ].
			cond printOn: aStream.
			self precedence <= cond precedence
				ifTrue: [ aStream nextPut: $) ] ]
		separatedBy: [ aStream nextPutAll: self operator ]
]

{ #category : #printing }
RMDBinaryCombinatorNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	conditions
		do: [ :cond | 
			self precedence <= cond precedence
				ifTrue: [ aStream nextPut: $( ].
			cond
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection.
			self precedence <= cond precedence
				ifTrue: [ aStream nextPut: $) ] ]
		separatedBy: [ aStream nextPutAll: self operator ].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDBinaryCombinatorNode >> replaceChildren: aDictionary [
	conditions := conditions
		collect: [ :node | node copyReplace: aDictionary ]
]
