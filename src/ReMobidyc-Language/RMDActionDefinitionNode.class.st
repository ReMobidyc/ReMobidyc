Class {
	#name : #RMDActionDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'guard',
		'propertyDefinitions',
		'utilityDefinitions',
		'object'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #examples }
RMDActionDefinitionNode class >> crop [
	<script: 'RMDActionDefinitionNode crop inspect'>
	^ 'to crop is
presume here''s grass > 0[kcal]
	here''s delta grass'' = -amount
	my delta energy'' = amount
where
	amount = min(my capacity - my energy, my diet).
' asRMDActionDefinition
]

{ #category : #examples }
RMDActionDefinitionNode class >> graze [
	<script: 'RMDActionDefinitionNode graze inspect'>
	^ 'to graze is
presume here''s grass > 0[kcal]
	here''s delta grass'' = -amount
	my delta energy'' = amount
where
	amount = min3(my capacity - my energy, my diet, here''s grass).
' asRMDActionDefinition
]

{ #category : #examples }
RMDActionDefinitionNode class >> grow [
	<script: 'RMDActionDefinitionNode grow inspect'>
	^ 'to grow is
presume here''s fertility > 0[kcal]
	here''s delta fertility'' = -amount
	here''s delta green'' = amount
where
	amount = min3(here''s transfer_rate, here''s fertility, here''s capacity - here''s green).
' asRMDActionDefinition
]

{ #category : #'instance creation' }
RMDActionDefinitionNode class >> name: scriptName object: objectName guard: aRMDCondition propertyDefinitions: anArrayOfRMDPropertyDefinition utilityDefinitions: anArrayOfRMDUtilityDefinition [
	^ self new
		identifier: scriptName;
		object: objectName;
		guard: (aRMDCondition ifNil: [ true ]);
		propertyDefinitions: (anArrayOfRMDPropertyDefinition ifNil: [ Array new ]);
		utilityDefinitions: (anArrayOfRMDUtilityDefinition ifNil: [ Array new ]);
		yourself
]

{ #category : #examples }
RMDActionDefinitionNode class >> walk [
	<script: 'RMDActionDefinitionNode walk inspect'>
	^ 'to walk is
presume here''s grass > 0[kcal]
	here''s delta grass'' = -amount
	my delta energy'' = amount
where
	amount = min(my capacity - my energy, my diet).
' asRMDActionDefinition
]

{ #category : #comparing }
RMDActionDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier
				and: [ guard = anObject guard
						and: [ propertyDefinitions = anObject propertyDefinitions
								and: [ utilityDefinitions = anObject utilityDefinitions
										and: [ object = anObject object ] ] ] ] ]
]

{ #category : #enumerating }
RMDActionDefinitionNode >> childrenDo: aBlock [
	aBlock value: aBlock.
	propertyDefinitions do: aBlock.
	utilityDefinitions do: aBlock
]

{ #category : #accessing }
RMDActionDefinitionNode >> guard [
	^ guard
]

{ #category : #accessing }
RMDActionDefinitionNode >> guard: aRMDCondition [
	guard := aRMDCondition
]

{ #category : #comparing }
RMDActionDefinitionNode >> hash [
	^ (((identifier hash bitXor: guard hash)
		bitXor: propertyDefinitions hash) bitXor: utilityDefinitions hash)
		bitXor: object hash
]

{ #category : #accessing }
RMDActionDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDActionDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDActionDefinitionNode >> isActionDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDActionDefinitionNode >> object [
	^ object
]

{ #category : #accessing }
RMDActionDefinitionNode >> object: aString [
	object := aString
]

{ #category : #copying }
RMDActionDefinitionNode >> postCopy [
	guard := guard ifNotNil: [ guard copy ].
	propertyDefinitions := propertyDefinitions
		ifNotNil: [ propertyDefinitions collect: #copy ].
	utilityDefinitions := utilityDefinitions
		ifNotNil: [ utilityDefinitions collect: #copy ]
]

{ #category : #printing }
RMDActionDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: 'to ';
		nextPutAll: identifier.
	object
		ifNotNil: [ aStream
				nextPut: Character space;
				nextPutAll: object ].
	aStream nextPutAll: ' is'.
	(guard notNil and: [ guard ~= true ])
		ifTrue: [ aStream
				nextPut: Character cr;
				nextPutAll: '    presume '.
			guard printOn: aStream ].
	propertyDefinitions
		do: [ :def | 
			aStream
				nextPut: Character cr;
				nextPutAll: '    '.
			def printOn: aStream ]
		separatedBy: [ aStream nextPut: Character cr ].
	utilityDefinitions
		ifNotEmpty: [ aStream
				nextPut: Character cr;
				nextPutAll: 'where';
				nextPut: Character cr.
			utilityDefinitions
				do: [ :def | 
					aStream nextPutAll: '    '.
					def printOn: aStream ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream
		nextPut: $.;
		nextPut: Character cr
]

{ #category : #accessing }
RMDActionDefinitionNode >> propertyDefinitions [
	^ propertyDefinitions
]

{ #category : #accessing }
RMDActionDefinitionNode >> propertyDefinitions: aRMDPropertyDefinitionNode [
	propertyDefinitions := aRMDPropertyDefinitionNode
]

{ #category : #rewriting }
RMDActionDefinitionNode >> replaceChildren: aDictionary [
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ].
	guard := guard ifNotNil: [ guard copyReplace: aDictionary ].
	propertyDefinitions := propertyDefinitions
		collect: [ :node | node copyReplace: aDictionary ].
	utilityDefinitions := utilityDefinitions
		collect: [ :node | node copyReplace: aDictionary ].
	aDictionary at: object ifPresent: [ :node | object := node copy ]
]

{ #category : #accessing }
RMDActionDefinitionNode >> utilityDefinitions [
	^ utilityDefinitions
]

{ #category : #accessing }
RMDActionDefinitionNode >> utilityDefinitions: anObject [
	utilityDefinitions := anObject
]
