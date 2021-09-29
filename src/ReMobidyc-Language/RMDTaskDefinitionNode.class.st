Class {
	#name : #RMDTaskDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'subjectIdentifier',
		'verbIdentifier',
		'actionIdentifier',
		'objectIdentifier',
		'range',
		'propertyBinds',
		'action',
		'name'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> cell_grow_grass: amountString upto: maxString [
	<script:
		'(RMDTaskDefinitionNode cell_grow_grass: ''1000[kcal/day]'' upto: ''10000[kcal]'') asPresenter openWithSpec'>
	^ ('Cell grow_grass namely gain_upto where
	my thing -> here''s grass
	my amount -> ' , amountString
		,
			' * delta time
	my maximum -> ' , maxString , '.') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_eat: dietString upto: maxString [
	<script:
		'(RMDTaskDefinitionNode goat_eat: ''1000[kcal/day]'' upto: ''10000[kcal]'') asPresenter openWithSpec'>
	^ ('Goat eat namely collect where
	my thing -> my blood_sugar
	here''s thing -> here''s grass
	my greed -> min(' , maxString, ' - my blood_sugar, ', dietString, ' * delta time, here''s grass).') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_graze: dietString upto: maxString [
	<script:
		'(RMDTaskDefinitionNode goat_graze: ''1000[kcal/day]'' upto: ''10000[kcal]'') asPresenter openWithSpec'>
	^ ('Goat graze namely collect where
	my thing -> my blood_sugar
	here''s thing -> here''s grass
	my greed -> min(' , maxString, ' - my blood_sugar, ', dietString, ' * delta time, here''s grass).') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_respire: aString [
	<script: '(RMDTaskDefinitionNode goat_respire: ''2000[kcal/day]'') asPresenter openWithSpec'>
	^ ('Goat respire namely lose where
	my thing -> my blood_sugar
	my amount -> min(my blood_sugar, ' , aString , ' * delta time).') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_walk_for_grass [
	<script:
		'RMDTaskDefinitionNode goat_walk_for_grass asPresenter openWithSpec'>
	^ 'Goat move where
	my heading -> direction neighbor''s grass
	my speed -> 1[km/day].' asRMDTaskDefinition
]

{ #category : #'instance creation' }
RMDTaskDefinitionNode class >> subjectIdentifier: agentString1 verbIdentifier: verbString objectIdentifier: agentString2 actionIdentifier: aRMDActionIdentifierNode within: aRMDLiteralNode propertyBinds: anArrayOfRMDPropertyBindNode [
	^ self new
		subjectIdentifier: agentString1;
		verbIdentifier: verbString;
		actionIdentifier: aRMDActionIdentifierNode;
		objectIdentifier: agentString2;
		range: aRMDLiteralNode;
		propertyBinds: anArrayOfRMDPropertyBindNode;
		yourself
]

{ #category : #comparing }
RMDTaskDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ subjectIdentifier = anObject subjectIdentifier
				and: [ verbIdentifier = anObject verbIdentifier
						and: [ objectIdentifier = anObject objectIdentifier
								and: [ range = anObject range
										and: [ propertyBinds = anObject propertyBinds
												and: [ actionIdentifier = anObject actionIdentifier ] ] ] ] ] ]
]

{ #category : #accessing }
RMDTaskDefinitionNode >> actionIdentifier [
	^ actionIdentifier
]

{ #category : #accessing }
RMDTaskDefinitionNode >> actionIdentifier: aRMDActionIdentifierNode [
	actionIdentifier := aRMDActionIdentifierNode.
	name := nil.
	self resetAction
]

{ #category : #accessing }
RMDTaskDefinitionNode >> actionWith: aRMDSimulationModel [
	^ action
		ifNil: [ action := ((actionIdentifier resolveWith: aRMDSimulationModel)
				copyReplace:
				(propertyBinds
				collect: [ :bind | 
					(RMDPropertyVariableNode
						identifier: bind actionProperty
						agent: bind actionAgent) -> bind expression ]) asDictionary)
				identifier: verbIdentifier;
				yourself ]
]

{ #category : #enumerating }
RMDTaskDefinitionNode >> childrenDo: aBlock [
	range ifNotNil: [ aBlock value: range ].
	aBlock value: actionIdentifier.
	propertyBinds do: aBlock
]

{ #category : #testing }
RMDTaskDefinitionNode >> hasObject [
	^ objectIdentifier notNil
]

{ #category : #comparing }
RMDTaskDefinitionNode >> hash [
	^ ((((subjectIdentifier hash bitXor: verbIdentifier hash)
		bitXor: objectIdentifier hash) bitXor: range hash)
		bitXor: propertyBinds hash) bitXor: actionIdentifier hash
]

{ #category : #testing }
RMDTaskDefinitionNode >> isTaskDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDTaskDefinitionNode >> name [
	^ name
		ifNil: [ name := String
				streamContents: [ :stream | 
					stream
						nextPutAll: subjectIdentifier;
						space;
						nextPutAll: verbIdentifier.
					objectIdentifier
						ifNotNil: [ stream
								space;
								nextPutAll: objectIdentifier ] ] ]
]

{ #category : #accessing }
RMDTaskDefinitionNode >> objectIdentifier [
	^ objectIdentifier
]

{ #category : #accessing }
RMDTaskDefinitionNode >> objectIdentifier: aString [
	objectIdentifier := aString.
	name := nil.
	self resetAction
]

{ #category : #copying }
RMDTaskDefinitionNode >> postCopy [
	range := range ifNotNil: #copy.
	propertyBinds := propertyBinds
		ifNotNil: [ propertyBinds collect: #copy ]
]

{ #category : #printing }
RMDTaskDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: subjectIdentifier;
		space;
		nextPutAll: verbIdentifier.
	objectIdentifier
		ifNotNil: [ aStream
				space;
				nextPutAll: objectIdentifier ].
	aStream
		space;
		nextPutAll: 'namely';
		space.
	actionIdentifier printOn: aStream.
	(propertyBinds notNil and: [ propertyBinds notEmpty ])
		ifTrue: [ aStream
				space;
				nextPutAll: 'where';
				nextPut: Character cr.
			propertyBinds
				do: [ :bind | 
					aStream nextPutAll: '    '.
					bind printOn: aStream ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $.
]

{ #category : #printing }
RMDTaskDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: subjectIdentifier;
		space;
		nextPutAll: verbIdentifier.
	objectIdentifier
		ifNotNil: [ aStream
				space;
				nextPutAll: objectIdentifier ].
	aStream
		space;
		nextPutAll: 'namely';
		space.
	actionIdentifier
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(propertyBinds notNil and: [ propertyBinds notEmpty ])
		ifTrue: [ aStream
				space;
				nextPutAll: 'where';
				nextPut: Character cr.
			propertyBinds
				do: [ :bind | 
					aStream nextPutAll: '    '.
					bind
						printOn: aStream
						ifIncludedIn: aCollectionOfRMDSyntaxNode
						addSectionTo: aCollection ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #accessing }
RMDTaskDefinitionNode >> propertyBinds [
	^ propertyBinds
]

{ #category : #accessing }
RMDTaskDefinitionNode >> propertyBinds: anArrayOfRMDPropertyBindNode [
	propertyBinds := anArrayOfRMDPropertyBindNode.
	self resetAction
]

{ #category : #accessing }
RMDTaskDefinitionNode >> range [
	^ range
]

{ #category : #accessing }
RMDTaskDefinitionNode >> range: aRMDLiteral [
	range := aRMDLiteral
]

{ #category : #rewriting }
RMDTaskDefinitionNode >> replaceChildren: aDictionary [
	aDictionary
		at: subjectIdentifier
		ifPresent: [ :node | subjectIdentifier := node copy ].
	aDictionary
		at: verbIdentifier
		ifPresent: [ :node | verbIdentifier := node copy ].
	aDictionary
		at: objectIdentifier
		ifPresent: [ :node | objectIdentifier := node copy ].
	range
		ifNotNil: [ range := aDictionary
				at: range
				ifPresent: #copy
				ifAbsent: [ range copyReplace: aDictionary ] ].
	propertyBinds := propertyBinds
		collect: [ :node | node copyReplace: aDictionary ].
	actionIdentifier := aDictionary
		at: actionIdentifier
		ifPresent: #copy
		ifAbsent: [ actionIdentifier copyReplace: aDictionary ]
]

{ #category : #accessing }
RMDTaskDefinitionNode >> resetAction [
	action := nil
]

{ #category : #accessing }
RMDTaskDefinitionNode >> subjectIdentifier [
	^ subjectIdentifier
]

{ #category : #accessing }
RMDTaskDefinitionNode >> subjectIdentifier: aString [
	subjectIdentifier := aString.
	name := nil.
	self resetAction
]

{ #category : #accessing }
RMDTaskDefinitionNode >> verbIdentifier [
	^ verbIdentifier 
]

{ #category : #accessing }
RMDTaskDefinitionNode >> verbIdentifier: aString [
	verbIdentifier := aString.
	self resetAction
]
