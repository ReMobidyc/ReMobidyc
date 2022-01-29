Class {
	#name : #RMDTaskDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'subjectIdentifier',
		'verbIdentifier',
		'objectIdentifier',
		'actionIdentifier',
		'guard',
		'range',
		'nearest',
		'propertyBinds',
		'action',
		'name'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> cell_grow_grass: amountString upto: maxString [

	<script:
	'(RMDTaskDefinitionNode cell_grow_grass: ''1000[kcal/day]'' upto: ''10000[kcal]'') inspect'>
	^ ('Cell grow namely gain
where
	the thing -> here''s grass
	the maximum -> ' , maxString , '
	the amount -> ' , amountString , ' * delta time .') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_eat: dietString upto: maxString [
	<script:
		'(RMDTaskDefinitionNode goat_eat: ''1000[kcal/day]'' upto: ''10000[kcal]'') inspect'>
	^ ('Goat eat namely transfer
when here''s grass > the amount and my blood_sugar < ', maxString, '
where
	the destination -> my blood_sugar
	the source -> here''s grass
	the amount -> ' ,  dietString, ' * delta time.') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_reproduce [

	<script: '(RMDTaskDefinitionNode goat_reproduce) inspect'>
	^ 'Goat reproduce namely reproduce
	where
	the chance -> 0.01
	new - -> new 1 Goat
	the min_blood_sugar -> 9000 [kcal]
	the initial_blood_sugar -> 2000 [kcal]
	the reproduction_cost -> 4000 [kcal].' asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_respire: aString [

	<script:
	'(RMDTaskDefinitionNode goat_respire: ''2000[kcal/day]'') asPresenter openWithSpec'>
	^ ('Goat respire namely lose
where
	the thing -> my blood_sugar
	the minimum -> 0 [kcal]
	the amount -> min(my blood_sugar, ' , aString , ' * delta time).')
		  asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_starve: thresholdString [

	<script:
	'(RMDTaskDefinitionNode goat_starve: ''1000[kcal/day]'') inspect'>
	^ ('Goat starve
where
	the vitality -> my blood_sugar
	the minimum -> ' , thresholdString , '.') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> goat_walk_for_grass [
	<script:
		'RMDTaskDefinitionNode goat_walk_for_grass asPresenter openWithSpec'>
	^ 'Goat move
where
	the heading -> direction neighbor''s grass
	the speed -> 1[km/day].' asRMDTaskDefinition
]

{ #category : #'instance creation' }
RMDTaskDefinitionNode class >> subjectIdentifier: agentString1 verbIdentifier: verbString objectIdentifier: agentString2 actionIdentifier: aRMDActionIdentifierNode nearest: aBoolean within: aRMDLiteralNode guard: aRMDConditionNode propertyBinds: anArrayOfRMDPropertyBindNode [

	^ self new
		  subjectIdentifier: agentString1;
		  verbIdentifier: verbString;
		  actionIdentifier: aRMDActionIdentifierNode;
		  objectIdentifier: agentString2;
		  nearest: aBoolean;
		  range: aRMDLiteralNode;
		  guard: aRMDConditionNode;
		  propertyBinds: anArrayOfRMDPropertyBindNode;
		  yourself
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> wolf_chase_goat [
	<script:
		'RMDTaskDefinitionNode wolf_chase_goat asPresenter openWithSpec'>
	^ 'Wolf chase nearest Goat within 10[km] namely move
where
	the heading -> direction goat
	the speed -> 1.0[km/day].' asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> wolf_prey_on_goat: maxString [
	<script:
		'(RMDTaskDefinitionNode wolf_prey_on_goat: ''15000[kcal]'') inspect'>
	^ ('Wolf prey_on nearest Goat within 1 [km]
	where
	the threshold -> ', maxString, '.') asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> wolf_reproduce [

	<script: '(RMDTaskDefinitionNode wolf_reproduce) inspect'>
	^ 'Wolf reproduce namely reproduce
	where
	the chance -> 0.01
	new - -> new 1 Wolf
	the min_blood_sugar -> 4000 [kcal]
	the initial_blood_sugar -> 2000 [kcal]
	the reproduction_cost -> 2000 [kcal].' asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> wolf_respire: aString [

	<script:
	'(RMDTaskDefinitionNode wolf_respire: ''1000[kcal/day]'') asPresenter openWithSpec'>
	^ ('Wolf respire namely lose
where
	the thing -> my blood_sugar
	the minimum -> 0 [kcal]
	the amount -> min(my blood_sugar, ' , aString , ' * delta time).')
		  asRMDTaskDefinition
]

{ #category : #'typical instances' }
RMDTaskDefinitionNode class >> wolf_starve: thresholdString [

	<script:
	'(RMDTaskDefinitionNode wolf_starve: ''100[kcal/day]'') inspect'>
	^ ('Wolf starve
where
	the vitality -> my blood_sugar
	the minimum -> ' , thresholdString , '.') asRMDTaskDefinition
]

{ #category : #comparing }
RMDTaskDefinitionNode >> = anObject [

	^ self class = anObject class and: [ 
		  subjectIdentifier = anObject subjectIdentifier and: [ 
			  verbIdentifier = anObject verbIdentifier and: [ 
				  objectIdentifier = anObject objectIdentifier and: [ 
					  range = anObject range and: [ 
						  propertyBinds = anObject propertyBinds and: [ 
							  actionIdentifier = anObject actionIdentifier ] ] ] ] ] ]
]

{ #category : #accessing }
RMDTaskDefinitionNode >> actionIdentifier [
	^ actionIdentifier
]

{ #category : #accessing }
RMDTaskDefinitionNode >> actionIdentifier: aRMDActionIdentifierNode [
	actionIdentifier := aRMDActionIdentifierNode.
	self resetAction
]

{ #category : #accessing }
RMDTaskDefinitionNode >> actionWith: aRMDSimulationModel [

	^ action ifNil: [ 
		  action := ((actionIdentifier resolveWith: aRMDSimulationModel)
			             copy
			             taskGuard: guard;
			             copyReplace: (propertyBinds collect: [ :bind | 
						              bind placeholder -> bind replacement ])
					             asDictionary)
			            identifier: verbIdentifier;
			            replaceObjectWith: objectIdentifier;
			            yourself ]
]

{ #category : #enumerating }
RMDTaskDefinitionNode >> childrenDo: aBlock [

	guard ifNotNil: [ aBlock value: guard ].
	range ifNotNil: [ aBlock value: range ].
	aBlock value: actionIdentifier.
	propertyBinds do: aBlock
]

{ #category : #private }
RMDTaskDefinitionNode >> createName [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: subjectIdentifier;
			  space;
			  nextPutAll: verbIdentifier.
		  objectIdentifier ifNotNil: [ 
			  stream
				  space;
				  nextPutAll: objectIdentifier ] ]
]

{ #category : #accessing }
RMDTaskDefinitionNode >> guard [

	^ guard
]

{ #category : #accessing }
RMDTaskDefinitionNode >> guard: aRMDConditionNode [

	guard := aRMDConditionNode
]

{ #category : #testing }
RMDTaskDefinitionNode >> hasObject [
	^ objectIdentifier notNil
]

{ #category : #comparing }
RMDTaskDefinitionNode >> hash [

	^ (((((self class hash bitXor: subjectIdentifier hash) bitXor:
		      range hash) bitXor: verbIdentifier hash) bitXor:
		    objectIdentifier hash) bitXor: propertyBinds hash) bitXor:
		  actionIdentifier hash
]

{ #category : #testing }
RMDTaskDefinitionNode >> isTaskDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDTaskDefinitionNode >> name [

	^ name ifNil: [ name := self createName ]
]

{ #category : #accessing }
RMDTaskDefinitionNode >> nearest [

	^ nearest
]

{ #category : #accessing }
RMDTaskDefinitionNode >> nearest: aBoolean [

	nearest := aBoolean
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
	guard := guard ifNotNil: #copy.
	propertyBinds := propertyBinds ifNotNil: [ 
		                 propertyBinds collect: #copy ].
	action := action ifNotNil: #copy
]

{ #category : #printing }
RMDTaskDefinitionNode >> printOn: aStream [

	aStream
		nextPutAll: subjectIdentifier;
		space;
		nextPutAll: verbIdentifier.
	objectIdentifier ifNotNil: [ 
		aStream space.
		nearest ifTrue: [ aStream nextPutAll: 'nearest ' ].
		aStream
			nextPutAll: objectIdentifier;
			nextPutAll: ' within '.
		range printOn: aStream.
		aStream space ].
	(actionIdentifier isBuiltinActionIdentifierNode and: [ 
		 actionIdentifier shortName = verbIdentifier ]) ifFalse: [ 
		aStream
			space;
			nextPutAll: 'namely';
			space.
		actionIdentifier printOn: aStream ].
	guard ifNotNil: [ 
		aStream
			cr;
			nextPutAll: 'when '.
		guard printOn: aStream ].
	(propertyBinds notNil and: [ propertyBinds notEmpty ]) ifTrue: [ 
		aStream
			cr;
			nextPutAll: 'where';
			cr.
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
	objectIdentifier ifNotNil: [ 
		aStream space.
		nearest ifTrue: [ aStream nextPutAll: 'nearest ' ].
		aStream
			nextPutAll: objectIdentifier;
			nextPutAll: ' within '.
		range
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection.
		aStream space ].
	(actionIdentifier isBuiltinActionIdentifierNode and: [ 
		 actionIdentifier shortName = verbIdentifier ]) ifFalse: [ 
		aStream
			space;
			nextPutAll: 'namely';
			space.
		actionIdentifier
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ].
	guard ifNotNil: [ 
		aStream
			cr;
			nextPutAll: 'when '.
		guard
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ].
	(propertyBinds notNil and: [ propertyBinds notEmpty ]) ifTrue: [ 
		aStream
			cr;
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
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
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
	guard ifNotNil: [ 
		guard := aDictionary
			         at: guard
			         ifPresent: #copy
			         ifAbsent: [ guard copyReplace: aDictionary ] ].
	aDictionary
		at: verbIdentifier
		ifPresent: [ :node | verbIdentifier := node copy ].
	aDictionary
		at: objectIdentifier
		ifPresent: [ :node | objectIdentifier := node copy ].
	range ifNotNil: [ 
		range := aDictionary
			         at: range
			         ifPresent: #copy
			         ifAbsent: [ range copyReplace: aDictionary ] ].
	propertyBinds := propertyBinds collect: [ :node | 
		                 node copyReplace: aDictionary ].
	actionIdentifier := aDictionary
		                    at: actionIdentifier
		                    ifPresent: #copy
		                    ifAbsent: [ 
		                    actionIdentifier copyReplace: aDictionary ]
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
