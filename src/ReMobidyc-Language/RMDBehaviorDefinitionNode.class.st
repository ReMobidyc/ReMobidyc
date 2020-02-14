Class {
	#name : #RMDBehaviorDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'subjectIdentifier',
		'scriptIdentifier',
		'objectIdentifier',
		'range',
		'propertyBinds'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDBehaviorDefinitionNode class >> subjectIdentifier: agentString1 scriptIdentifier: scriptString1 objectIdentifier: agentString2 within: aRMDLiteralNode propertyBinds: anArrayOfRMDPropertyBindNode [
	^ self new
		subjectIdentifier: agentString1;
		scriptIdentifier: scriptString1;
		objectIdentifier: agentString2;
		range: aRMDLiteralNode;
		propertyBinds: anArrayOfRMDPropertyBindNode;
		yourself
]

{ #category : #enumerating }
RMDBehaviorDefinitionNode >> childrenDo: aBlock [
	aBlock value: range.
	propertyBinds do: aBlock
]

{ #category : #testing }
RMDBehaviorDefinitionNode >> hasObject [
	^ objectIdentifier notNil
]

{ #category : #testing }
RMDBehaviorDefinitionNode >> isBehaviorDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> objectIdentifier [
	^ objectIdentifier
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> objectIdentifier: aString [
	objectIdentifier := aString
]

{ #category : #printing }
RMDBehaviorDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: subjectIdentifier;
		nextPutAll: ' can ';
		nextPutAll: scriptIdentifier.
	objectIdentifier
		ifNotNil: [ aStream
				nextPut: Character space;
				nextPutAll: objectIdentifier ].
	propertyBinds
		ifNotNil: [ aStream nextPutAll: ' where '.
			propertyBinds
				do: [ :bind | bind printOn: aStream ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $.
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> propertyBinds [
	^ propertyBinds
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> propertyBinds: anArrayOfRMDPropertyBindNode [
	propertyBinds := anArrayOfRMDPropertyBindNode
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> range [
	^ range
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> range: aRMDLiteral [
	range := aRMDLiteral
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> scriptIdentifier [
	^ scriptIdentifier
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> scriptIdentifier: aString [
	scriptIdentifier := aString
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> subjectIdentifier [
	^ subjectIdentifier
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> subjectIdentifier: aString [
	subjectIdentifier := aString
]
