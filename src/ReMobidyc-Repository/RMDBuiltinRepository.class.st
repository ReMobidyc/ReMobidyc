Class {
	#name : #RMDBuiltinRepository,
	#superclass : #RMDRepository,
	#classInstVars : [
		'current'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #accessing }
RMDBuiltinRepository class >> actionNamed: aString ifAbsent: errorBlock [
	^ self current actionNamed: aString ifAbsent: errorBlock
]

{ #category : #accessing }
RMDBuiltinRepository class >> actionNames [
	^ self current actionNames
]

{ #category : #'sole instance' }
RMDBuiltinRepository class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #accessing }
RMDBuiltinRepository >> actionIdentifiers [
	^ self actionNames
		collect:
			[ :actionName | RMDBuiltinActionIdentifierNode identifier: actionName ]
]

{ #category : #accessing }
RMDBuiltinRepository >> actionNamed: aString ifAbsent: errorBlock [
	^ (self actionNames includes: aString)
		ifTrue: [ self perform: aString asSymbol ]
		ifFalse: errorBlock
]

{ #category : #accessing }
RMDBuiltinRepository >> actionNames [
	^ (self class selectorsInProtocol: 'actions') collect: #asString
]

{ #category : #actions }
RMDBuiltinRepository >> collect [
	^ RMDActionDefinitionNode collect
]

{ #category : #actions }
RMDBuiltinRepository >> collect_if_below [
	^ RMDActionDefinitionNode collect_if_below
]

{ #category : #actions }
RMDBuiltinRepository >> convert [
	^ RMDActionDefinitionNode convert
]

{ #category : #actions }
RMDBuiltinRepository >> diffuse [
	^ RMDActionDefinitionNode diffuse
]

{ #category : #actions }
RMDBuiltinRepository >> gain [
	^ 'to gain is
	my delta thing'' = my amount.' asRMDActionDefinition
]

{ #category : #actions }
RMDBuiltinRepository >> gain_if_below [
	^ 'to gain_if_below is
	presume my thing < my threshold
	my delta thing'' = my amount.' asRMDActionDefinition
]

{ #category : #actions }
RMDBuiltinRepository >> gain_upto [
	^ 'to gain_upto is
	my delta thing'' = min(my amount, my maximum - my thing).' asRMDActionDefinition
]

{ #category : #testing }
RMDBuiltinRepository >> includesActionIdentifier: aRMDActionIdentifierNode [
	^ aRMDActionIdentifierNode isBuiltinActionIdentifierNode
		and: [ super includesActionIdentifier: aRMDActionIdentifierNode ]
]

{ #category : #actions }
RMDBuiltinRepository >> lose [
	^ RMDActionDefinitionNode lose
]

{ #category : #actions }
RMDBuiltinRepository >> move [
	^ RMDActionDefinitionNode move
]

{ #category : #accessing }
RMDBuiltinRepository >> name [
	'Built-in'
]

{ #category : #accessing }
RMDBuiltinRepository >> repositoryName [
	^ 'Built-in'
]

{ #category : #actions }
RMDBuiltinRepository >> respire [
	^ RMDActionDefinitionNode respire
]
