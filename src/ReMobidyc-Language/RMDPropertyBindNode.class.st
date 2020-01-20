Class {
	#name : #RMDPropertyBindNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'scriptAgent',
		'scriptProperty',
		'animatProperty'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyBindNode class >> scriptAgent: agentStringOrNil property: propertyString1 animatProperty: propertyString2 [
	^ self new
		scriptAgent: agentStringOrNil;
		scriptProperty: propertyString1;
		animatProperty: propertyString2;
		yourself
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
	scriptAgent
		ifNil: [ aStream nextPutAll: 'my ' ]
		ifNotNil: [ aStream
				nextPutAll: scriptAgent;
				nextPutAll: '''s ' ].
	aStream
		nextPutAll: scriptProperty;
		nextPutAll: ' -> '.
	aStream nextPutAll: animatProperty
]

{ #category : #accessing }
RMDPropertyBindNode >> scriptAgent [
	^ scriptAgent
]

{ #category : #accessing }
RMDPropertyBindNode >> scriptAgent: aString [
	scriptAgent := aString
]

{ #category : #accessing }
RMDPropertyBindNode >> scriptProperty [
	^ scriptProperty
]

{ #category : #accessing }
RMDPropertyBindNode >> scriptProperty: aString [
	scriptProperty := aString
]
