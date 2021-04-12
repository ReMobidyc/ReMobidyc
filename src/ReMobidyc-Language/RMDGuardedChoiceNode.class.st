Class {
	#name : #RMDGuardedChoiceNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'guardsAndChoices'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDGuardedChoiceNode class >> from: anArrayOfAssociation [
	^ self new
		guardsAndChoices: anArrayOfAssociation;
		yourself
]

{ #category : #comparing }
RMDGuardedChoiceNode >> = anObject [
	^ self class = anObject class
		and: [ guardsAndChoices = anObject guardsAndChoices ]
]

{ #category : #enumerating }
RMDGuardedChoiceNode >> childrenDo: aBlock [
	guardsAndChoices
		do: [ :assoc | 
			aBlock
				value: assoc key;
				value: assoc value ]
]

{ #category : #private }
RMDGuardedChoiceNode >> guardsAndChoices [
	^ guardsAndChoices
]

{ #category : #private }
RMDGuardedChoiceNode >> guardsAndChoices: anArrayOfAssociation [
	guardsAndChoices := anArrayOfAssociation
]

{ #category : #comparing }
RMDGuardedChoiceNode >> hash [
	^ self class hash bitXor: guardsAndChoices hash
]

{ #category : #testing }
RMDGuardedChoiceNode >> isGuardedChoiceNode [
	^ true
]

{ #category : #copying }
RMDGuardedChoiceNode >> postCopy [
	guardsAndChoices := guardsAndChoices collect: #copy
]

{ #category : #accessing }
RMDGuardedChoiceNode >> precedence [
	^ 100
]

{ #category : #printing }
RMDGuardedChoiceNode >> printInlineOn: aStream [
	guardsAndChoices
		do: [ :assoc | 
			| guard expr |
			guard := assoc key.
			expr := assoc value.
			expr printOn: aStream.
			guard = true
				ifFalse: [ aStream nextPutAll: ' if '.
					guard printOn: aStream ] ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #printing }
RMDGuardedChoiceNode >> printMultilineIndent: anInteger on: aStream [
	guardsAndChoices
		do: [ :assoc | 
			| guard expr |
			guard := assoc key.
			expr := assoc value.
			anInteger * 4 timesRepeat: [ aStream nextPut: Character space ].
			expr printOn: aStream.
			guard = true
				ifFalse: [ aStream nextPutAll: ' if '.
					guard printOn: aStream ] ]
		separatedBy: [ aStream
				nextPut: $,;
				nextPut: Character cr ]
]

{ #category : #printing }
RMDGuardedChoiceNode >> printOn: aStream [
	self printInlineOn: aStream
]

{ #category : #rewriting }
RMDGuardedChoiceNode >> replaceChildren: aDictionary [
	guardsAndChoices := guardsAndChoices
		collect: [ :assoc | 
			assoc key = true
				ifTrue: [ true -> (assoc value copyReplace: aDictionary) ]
				ifFalse: [ (assoc key copyReplace: aDictionary)
						-> (assoc value copyReplace: aDictionary) ] ]
]
