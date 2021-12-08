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
RMDBuiltinRepository >> gain [
	^ 'to gain is
	the delta thing'' = the amount.' asRMDActionDefinition
]

{ #category : #actions }
RMDBuiltinRepository >> gain_upto [
	^ 'to gain_upto is
	when the thing < the maximum
	the delta thing'' = amount
	where
	amount = positive(min(the amount, the maximum - the thing)).' asRMDActionDefinition
]

{ #category : #testing }
RMDBuiltinRepository >> includesActionIdentifier: aRMDActionIdentifierNode [
	^ aRMDActionIdentifierNode isBuiltinActionIdentifierNode
		and: [ super includesActionIdentifier: aRMDActionIdentifierNode ]
]

{ #category : #actions }
RMDBuiltinRepository >> lose [
	^ 'to lose is
	the delta thing'' = - amount
	where
	amount = positive(min(the amount, the thing)).' asRMDActionDefinition
]

{ #category : #actions }
RMDBuiltinRepository >> lose_downto [

	^ 'to lose is
	the delta thing'' = - amount
	where
	amount = positive(min(the amount, the minimum)).' asRMDActionDefinition
]

{ #category : #actions }
RMDBuiltinRepository >> move [

	^ 'to move is
	my d/dt x'' = cos(theta) * r
	my d/dt y'' = sin(theta) * r
where
	theta = the heading
	r = the speed.' asRMDActionDefinition
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
RMDBuiltinRepository >> transfer [

	^ 'to transfer is
	the delta source'' = - amount
	the delta destination'' = amount
where
	amount = the amount.
' asRMDActionDefinition
]

{ #category : #actions }
RMDBuiltinRepository >> transfer_upto [

	^ 'to transfer_upto is
	the delta source'' = - amount
	the delta destination'' = amount
where
	amount = positive(min(the amount, the source, the maximum - the destination)).
' asRMDActionDefinition
]
