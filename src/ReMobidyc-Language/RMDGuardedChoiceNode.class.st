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

{ #category : #evaluating }
RMDGuardedChoiceNode >> evalIn: aRMDInterpreter [
	guardsAndChoices
		do: [ :assoc | 
			(assoc key evalIn: aRMDInterpreter) = true
				ifTrue: [ ^ assoc value evalIn: aRMDInterpreter ] ].
	^ self error: 'All guards failed'
]

{ #category : #private }
RMDGuardedChoiceNode >> guardsAndChoices: anArrayOfAssociation [
	guardsAndChoices := anArrayOfAssociation
]

{ #category : #testing }
RMDGuardedChoiceNode >> isGuardedChoiceNode [
	^ true
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
