Class {
	#name : #RMDTypechecker,
	#superclass : #RMDAbstractInterpreter,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #examples }
RMDTypechecker class >> sugarScape [
	<script: 'RMDTypechecker sugarScape inspect'>
	| typechecker |
	typechecker := self new
		simulationModel: RMDSimulationModel sugarScape;
		yourself.
	^ typechecker
]

{ #category : #directives }
RMDTypechecker >> changeStage: animatString [

	| animatDefinition |
	animatDefinition := simulationModel
		                    animatDefinitionAt: animatString
		                    ifAbsent: [ 
		                    ^ RMDUnresolvedReferenceError on: self ].
	context newDefinition: animatDefinition.
	^ animatString
]

{ #category : #directives }
RMDTypechecker >> newIndividual: animatString [

	| animatDefinition |
	animatDefinition := simulationModel
		                    animatDefinitionAt: animatString
		                    ifAbsent: [ 
		                    ^ RMDUnresolvedReferenceError on: self ].
	context newDefinition: animatDefinition.
	^ animatString
]

{ #category : #'type checking' }
RMDTypechecker >> newTypecheckContext [
	^ RMDTypecheckContext new
		patchDefinition: self patchDefinition;
		worldDefinition: self worldDefinition;
		yourself
]

{ #category : #'type checking' }
RMDTypechecker >> newTypecheckContextForAnimat: aString [
	^ self newTypecheckContext
		subjectDefinition:
			(self
				animatDefinitionAt: aString
				ifAbsent: [ ^ KeyNotFound signal: aString ]);
		yourself
]

{ #category : #'type checking' }
RMDTypechecker >> newTypecheckContextForPatch [
	^ self newTypecheckContext 
		subjectDefinition: self patchDefinition;
		yourself
]

{ #category : #'type checking' }
RMDTypechecker >> newTypecheckContextForTask: aRMDTaskDefinitionNode [

	| subject newContext |
	subject := aRMDTaskDefinitionNode subjectIdentifier.
	newContext := subject = 'World'
		              ifTrue: [ self newTypecheckContextForWorld ]
		              ifFalse: [ 
			              subject = 'Patch'
				              ifTrue: [ self newTypecheckContextForPatch ]
				              ifFalse: [ 
				              self newTypecheckContextForAnimat: subject ] ].
	aRMDTaskDefinitionNode hasObject ifTrue: [ 
		| object |
		object := aRMDTaskDefinitionNode objectIdentifier.
		newContext object: object definition: (self
				 animatDefinitionAt: object
				 ifAbsent: [ 
				 ^ (RMDUnresolvedReferenceError on: aRMDTaskDefinitionNode) signal ]) ].
	newContext action: (aRMDTaskDefinitionNode actionWith: self).
	^ newContext
]

{ #category : #'type checking' }
RMDTypechecker >> newTypecheckContextForWorld [
	^ self newTypecheckContext 
		subjectDefinition: self worldDefinition;
		yourself
]

{ #category : #'type checking' }
RMDTypechecker >> typeOfDirective: aString [
	aString = 'directionOfGradient'
		ifTrue: [ ^ RMDType rad ].
	aString = 'direction'
		ifTrue: [ ^ RMDType rad ].
	aString = 'distance'
		ifTrue: [ ^ RMDType m ].
	aString = 'time'
		ifTrue: [ ^ RMDType s ].
	aString = 'delta time'
		ifTrue: [ ^ RMDType s ].
	aString = 'terminate'
		ifTrue: [ ^ RMDType noDimension ].
	^ KeyNotFound signal: aString
]

{ #category : #'type checking' }
RMDTypechecker >> typeOfUtilityVariable: aString ifAbsent: errorBlock [
	^ (self context typeAt: aString ifAbsent: errorBlock)
		typecheckIn: self
]

{ #category : #'type checking' }
RMDTypechecker >> typeOfVariable: aString agent: anotherString ifAbsent: errorBlock [
	^ context
		typeOfVariable: aString
		agent: anotherString
		ifAbsent: errorBlock
]

{ #category : #'type checking' }
RMDTypechecker >> typeUtilityVariable: aString as: aRMDType [
	self context typeAt: aString put: aRMDType
]

{ #category : #'type checking' }
RMDTypechecker >> typecheck [
	self
		typecheckInitializers;
		typecheckTasks
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckInitializers [
	self
		withContext: self newTypecheckContextForWorld
		do: [ simulationModel worldInitializer typecheckIn: self ].
	self
		withContext: self newTypecheckContextForPatch
		do: [ simulationModel patchInitializer typecheckIn: self ].
	simulationModel
		animatInitializersDo: [ :animatInitializer | 
			self
				withContext: (self newTypecheckContextForAnimat: animatInitializer animat)
				do: [ animatInitializer typecheckIn: self ] ]
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckTask: aRMDTaskDefinitionNode [
	self
		withContext: (self newTypecheckContextForTask: aRMDTaskDefinitionNode)
		do: [ aRMDTaskDefinitionNode typecheckIn: self ]
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckTasks [
	simulationModel
		taskDefinitionsDo: [ :taskDefinition | 
			self
				withContext: (self newTypecheckContextForTask: taskDefinition)
				do: [ taskDefinition typecheckIn: self ] ]
]
