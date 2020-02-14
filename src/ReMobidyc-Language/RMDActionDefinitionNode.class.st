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

{ #category : #accessing }
RMDActionDefinitionNode >> utilityDefinitions [
	^ utilityDefinitions
]

{ #category : #accessing }
RMDActionDefinitionNode >> utilityDefinitions: anObject [
	utilityDefinitions := anObject
]
