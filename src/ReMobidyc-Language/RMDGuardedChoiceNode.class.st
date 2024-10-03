Class {
	#name : 'RMDGuardedChoiceNode',
	#superclass : 'RMDExpressionNode',
	#instVars : [
		'guardsAndChoices'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDGuardedChoiceNode class >> from: anArrayOfAssociation [
	^ self new
		guardsAndChoices: anArrayOfAssociation;
		yourself
]

{ #category : 'comparing' }
RMDGuardedChoiceNode >> = anObject [
	^ self class = anObject class
		and: [ guardsAndChoices = anObject guardsAndChoices ]
]

{ #category : 'converting' }
RMDGuardedChoiceNode >> asPresenter [

	^ RMDGuardedChoicePresenter on: self
]

{ #category : 'enumerating' }
RMDGuardedChoiceNode >> childrenDo: aBlock [

	guardsAndChoices do: [ :assoc |
		assoc key = true ifFalse: [ aBlock value: assoc key ].
		aBlock value: assoc value ]
]

{ #category : 'enumerating' }
RMDGuardedChoiceNode >> childrenTransform: aBlock [

	guardsAndChoices := guardsAndChoices collect: [ :assoc |
		                    (assoc key = true
			                     ifTrue: [ true ]
			                     ifFalse: [ aBlock value: assoc key ])
		                    -> (aBlock value: assoc value) ]
]

{ #category : 'private' }
RMDGuardedChoiceNode >> guardsAndChoices [
	^ guardsAndChoices
]

{ #category : 'private' }
RMDGuardedChoiceNode >> guardsAndChoices: anArrayOfAssociation [
	guardsAndChoices := anArrayOfAssociation
]

{ #category : 'testing' }
RMDGuardedChoiceNode >> hasConditionPlaceholder: aRMDPlaceholder [

	guardsAndChoices do: [ :assoc | 
		assoc key = aRMDPlaceholder ifTrue: [ ^ true ] ].
	^ super hasConditionPlaceholder: aRMDPlaceholder
]

{ #category : 'comparing' }
RMDGuardedChoiceNode >> hash [
	^ self class hash bitXor: guardsAndChoices hash
]

{ #category : 'testing' }
RMDGuardedChoiceNode >> isGuardedChoiceNode [
	^ true
]

{ #category : 'copying' }
RMDGuardedChoiceNode >> postCopy [
	guardsAndChoices := guardsAndChoices collect: #copy
]

{ #category : 'accessing' }
RMDGuardedChoiceNode >> precedence [
	^ 100
]

{ #category : 'printing' }
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

{ #category : 'printing' }
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

{ #category : 'printing' }
RMDGuardedChoiceNode >> printOn: aStream [
	self printInlineOn: aStream
]

{ #category : 'printing' }
RMDGuardedChoiceNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	self printInlineOn: aStream.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDGuardedChoiceNode >> replaceChildren: aDictionary [
	guardsAndChoices := guardsAndChoices
		collect: [ :assoc | 
			assoc key = true
				ifTrue: [ true -> (assoc value copyReplace: aDictionary) ]
				ifFalse: [ (assoc key copyReplace: aDictionary)
						-> (assoc value copyReplace: aDictionary) ] ]
]
