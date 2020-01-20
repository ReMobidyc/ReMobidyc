Class {
	#name : #RMDBindNode,
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
RMDBindNode class >> subjectIdentifier: agentString1 scriptIdentifier: scriptString1 objectIdentifier: agentString2 within: aRMDLiteralNode propertyBinds: anArrayOfRMDPropertyBindNode [
	^ self new
		subjectIdentifier: agentString1;
		scriptIdentifier: scriptString1;
		objectIdentifier: agentString2;
		range: aRMDLiteralNode;
		propertyBinds: anArrayOfRMDPropertyBindNode;
		yourself
]

{ #category : #testing }
RMDBindNode >> hasObject [
	^ objectIdentifier notNil
]

{ #category : #testing }
RMDBindNode >> isBindNode [
	^ true
]

{ #category : #accessing }
RMDBindNode >> objectIdentifier [
	^ objectIdentifier
]

{ #category : #accessing }
RMDBindNode >> objectIdentifier: aString [
	objectIdentifier := aString
]

{ #category : #printing }
RMDBindNode >> printOn: aStream [
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
RMDBindNode >> propertyBinds [
	^ propertyBinds
]

{ #category : #accessing }
RMDBindNode >> propertyBinds: anArrayOfRMDPropertyBindNode [
	propertyBinds := anArrayOfRMDPropertyBindNode
]

{ #category : #accessing }
RMDBindNode >> range [
	^ range
]

{ #category : #accessing }
RMDBindNode >> range: aRMDLiteral [
	range := aRMDLiteral
]

{ #category : #accessing }
RMDBindNode >> scriptIdentifier [
	^ scriptIdentifier
]

{ #category : #accessing }
RMDBindNode >> scriptIdentifier: aString [
	scriptIdentifier := aString
]

{ #category : #accessing }
RMDBindNode >> subjectIdentifier [
	^ subjectIdentifier
]

{ #category : #accessing }
RMDBindNode >> subjectIdentifier: aString [
	subjectIdentifier := aString
]
