Class {
	#name : #RMDPropertyBindNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'animatProperty',
		'actionAgent',
		'actionProperty'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyBindNode class >> scriptAgent: agentStringOrNil property: propertyString1 animatProperty: propertyString2 [
	^ self new
		actionAgent: agentStringOrNil;
		actionProperty: propertyString1;
		animatProperty: propertyString2;
		yourself
]

{ #category : #accessing }
RMDPropertyBindNode >> actionAgent [
	^ actionAgent
]

{ #category : #accessing }
RMDPropertyBindNode >> actionAgent: aString [
	actionAgent := aString
]

{ #category : #accessing }
RMDPropertyBindNode >> actionProperty [
	^ actionProperty
]

{ #category : #accessing }
RMDPropertyBindNode >> actionProperty: aString [
	actionProperty := aString
]

{ #category : #accessing }
RMDPropertyBindNode >> animatProperty [
	^ animatProperty
]

{ #category : #accessing }
RMDPropertyBindNode >> animatProperty: aString [
	animatProperty := aString
]

{ #category : #testing }
RMDPropertyBindNode >> isPropertyBindNode [
	^ true
]

{ #category : #printing }
RMDPropertyBindNode >> printOn: aStream [
	actionAgent
		ifNil: [ aStream nextPutAll: 'my ' ]
		ifNotNil: [ aStream
				nextPutAll: actionAgent;
				nextPutAll: '''s ' ].
	aStream
		nextPutAll: actionProperty;
		nextPutAll: ' -> '.
	aStream nextPutAll: animatProperty
]
