Class {
	#name : #RMDBehaviorDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'subjectIdentifier',
		'actionIdentifier',
		'objectIdentifier',
		'range',
		'propertyBinds',
		'action'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDBehaviorDefinitionNode class >> subjectIdentifier: agentString1 scriptIdentifier: scriptString1 objectIdentifier: agentString2 within: aRMDLiteralNode propertyBinds: anArrayOfRMDPropertyBindNode [
	^ self new
		subjectIdentifier: agentString1;
		actionIdentifier: scriptString1;
		objectIdentifier: agentString2;
		range: aRMDLiteralNode;
		propertyBinds: anArrayOfRMDPropertyBindNode;
		yourself
]

{ #category : #comparing }
RMDBehaviorDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ subjectIdentifier = anObject subjectIdentifier
				and: [ objectIdentifier = anObject objectIdentifier
						and: [ range = anObject range
								and: [ propertyBinds = anObject propertyBinds and: [ actionIdentifier ] ] ] ] ]
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> actionIdentifier [
	^ actionIdentifier
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> actionIdentifier: aString [
	actionIdentifier := aString
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> actionWith: aRMDInterpreter [
	^ action
		ifNil: [ action := (aRMDInterpreter
				actionDefinitionAt: actionIdentifier
				ifAbsent: [ ^ KeyNotFound signal: actionIdentifier ])
				copyReplace:
					(propertyBinds
						collect: [ :bind | 
							(RMDPropertyVariableNode
								identifier: bind actionProperty
								agent: bind actionAgent) -> bind expression ]) asDictionary ]
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

{ #category : #comparing }
RMDBehaviorDefinitionNode >> hash [
	^ (((subjectIdentifier hash bitXor: objectIdentifier hash)
		bitXor: range hash) bitXor: propertyBinds hash)
		bitXor: actionIdentifier hash
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

{ #category : #copying }
RMDBehaviorDefinitionNode >> postCopy [
	range := range ifNotNil: #copy.
	propertyBinds := propertyBinds
		ifNotNil: [ propertyBinds collect: #copy ]
]

{ #category : #printing }
RMDBehaviorDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: subjectIdentifier;
		nextPutAll: ' can ';
		nextPutAll: actionIdentifier.
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

{ #category : #rewriting }
RMDBehaviorDefinitionNode >> replaceChildren: aDictionary [
	aDictionary
		at: subjectIdentifier
		ifPresent: [ :node | subjectIdentifier := node copy ].
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
	aDictionary
		at: actionIdentifier
		ifPresent: [ :node | actionIdentifier := node copy ]
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> subjectIdentifier [
	^ subjectIdentifier
]

{ #category : #accessing }
RMDBehaviorDefinitionNode >> subjectIdentifier: aString [
	subjectIdentifier := aString
]
