Class {
	#name : #RMDBuiltinRepository,
	#superclass : #RMDRepository,
	#category : #'ReMobidyc-Repository'
}

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
RMDBuiltinRepository >> convert [
	^ RMDActionDefinitionNode convert
]

{ #category : #actions }
RMDBuiltinRepository >> diffuse [
	^ RMDActionDefinitionNode diffuse
]

{ #category : #actions }
RMDBuiltinRepository >> gain [
	^ RMDActionDefinitionNode gain
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

{ #category : #actions }
RMDBuiltinRepository >> respire [
	^ RMDActionDefinitionNode respire
]
