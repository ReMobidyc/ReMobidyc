Class {
	#name : #RMDAbstractTaskDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'guard',
		'subjectIdentifier',
		'name'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDAbstractTaskDefinitionNode >> = anObject [

	^ self class = anObject class and: [ 
		  subjectIdentifier = anObject subjectIdentifier ]
]

{ #category : #accessing }
RMDAbstractTaskDefinitionNode >> actionWith: aRMDInterpreter [

	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDAbstractTaskDefinitionNode >> childrenDo: aBlock [

	guard ifNotNil: [ aBlock value: guard ]
]

{ #category : #private }
RMDAbstractTaskDefinitionNode >> createName [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAbstractTaskDefinitionNode >> guard [

	^ guard
]

{ #category : #accessing }
RMDAbstractTaskDefinitionNode >> guard: aRMDConditionNode [

	guard := aRMDConditionNode
]

{ #category : #testing }
RMDAbstractTaskDefinitionNode >> hasObject [

	^ self subclassResponsibility
]

{ #category : #comparing }
RMDAbstractTaskDefinitionNode >> hash [

	^ self class hash bitXor: subjectIdentifier hash
]

{ #category : #accessing }
RMDAbstractTaskDefinitionNode >> name [

	^ name ifNil: [ name := self createName ]
]

{ #category : #copying }
RMDAbstractTaskDefinitionNode >> postCopy [

	guard := guard ifNotNil: #copy
]

{ #category : #rewriting }
RMDAbstractTaskDefinitionNode >> replaceChildren: aDictionary [

	aDictionary
		at: subjectIdentifier
		ifPresent: [ :node | subjectIdentifier := node copy ].
	guard ifNotNil: [ 
		guard := aDictionary
			         at: guard
			         ifPresent: #copy
			         ifAbsent: [ guard copyReplace: aDictionary ] ]
]

{ #category : #accessing }
RMDAbstractTaskDefinitionNode >> subjectIdentifier [
	^ subjectIdentifier
]

{ #category : #accessing }
RMDAbstractTaskDefinitionNode >> subjectIdentifier: aString [

	subjectIdentifier := aString.
	name := nil
]
