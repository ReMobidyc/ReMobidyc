Class {
	#name : #RMDScriptNode,
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
RMDScriptNode class >> name: scriptName object: objectName guard: aRMDCondition propertyDefinitions: anArrayOfRMDPropertyDefinition utilityDefinitions: anArrayOfRMDUtilityDefinition [
	^ self new
		identifier: scriptName;
		object: objectName;
		guard: (aRMDCondition ifNil: [ true ]);
		propertyDefinitions: (anArrayOfRMDPropertyDefinition ifNil: [ Array new ]);
		utilityDefinitions: (anArrayOfRMDUtilityDefinition ifNil: [ Array new ]);
		yourself
]

{ #category : #accessing }
RMDScriptNode >> guard [
	^ guard
]

{ #category : #accessing }
RMDScriptNode >> guard: aRMDCondition [
	guard := aRMDCondition
]

{ #category : #accessing }
RMDScriptNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDScriptNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDScriptNode >> isScriptNode [
	^ true
]

{ #category : #accessing }
RMDScriptNode >> object [
	^ object
]

{ #category : #accessing }
RMDScriptNode >> object: aString [
	object := aString
]

{ #category : #printing }
RMDScriptNode >> printOn: aStream [
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
RMDScriptNode >> propertyDefinitions [
	^ propertyDefinitions
]

{ #category : #accessing }
RMDScriptNode >> propertyDefinitions: aRMDPropertyDefinitionNode [
	propertyDefinitions := aRMDPropertyDefinitionNode
]

{ #category : #accessing }
RMDScriptNode >> utilityDefinitions [
	^ utilityDefinitions
]

{ #category : #accessing }
RMDScriptNode >> utilityDefinitions: anObject [
	utilityDefinitions := anObject
]
