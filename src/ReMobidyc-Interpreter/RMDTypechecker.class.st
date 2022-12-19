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

{ #category : #directives }
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

{ #category : #'variable access' }
RMDTypechecker >> typeOfUtilityVariable: aString ifAbsent: errorBlock [

	^ self context typeAt: aString ifAbsentPut: [ 
		  (self context utilityAt: aString ifAbsent: [ ^ errorBlock value ]) 
			  typecheckIn: self ]
]

{ #category : #'variable access' }
RMDTypechecker >> typeOfVariable: aString agent: anotherString ifAbsent: errorBlock [
	^ context
		typeOfVariable: aString
		agent: anotherString
		ifAbsent: errorBlock
]

{ #category : #'variable access' }
RMDTypechecker >> typeUtilityVariable: aString as: aRMDType [

	self context typeAt: aString put: aRMDType.
	^ aRMDType
]

{ #category : #'type checking' }
RMDTypechecker >> typecheck: aRMDSyntaxNode [

	^ self typecheck: aRMDSyntaxNode subject: nil object: nil
]

{ #category : #'type checking' }
RMDTypechecker >> typecheck: aRMDSyntaxNode subject: aString [

	^ self typecheck: aRMDSyntaxNode subject: aString object: nil
]

{ #category : #'type checking' }
RMDTypechecker >> typecheck: aRMDSyntaxNode subject: aString object: anotherString [

	^ self
		  withSubject: aString
		  object: anotherString
		  do: [ aRMDSyntaxNode typecheckIn: self ]
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckAll [
	self
		typecheckInitializers;
		typecheckTasks
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckInitializers [

	self
		typecheck: simulationModel worldInitializer
		subject: simulationModel worldDefinition.
	self
		typecheck: simulationModel patchInitializer
		subject: simulationModel patchDefinition.
	simulationModel animatInitializersDo: [ :animatInitializer | 
		self typecheck: animatInitializer subject: animatInitializer animat ]
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckTasks [

	simulationModel taskDefinitionsDo: [ :taskDefinition | 
		self
			typecheck: taskDefinition
			subject: taskDefinition subjectIdentifier
			object: taskDefinition objectIdentifier ]
]

{ #category : #'type checking' }
RMDTypechecker >> weakTypecheck: aRMDSyntaxNode [

	^ self weakTypecheck: aRMDSyntaxNode subject: nil object: nil
]

{ #category : #'type checking' }
RMDTypechecker >> weakTypecheck: aRMDSyntaxNode subject: subject [

	^ self weakTypecheck: aRMDSyntaxNode subject: subject object: nil
]

{ #category : #'type checking' }
RMDTypechecker >> weakTypecheck: aRMDSyntaxNode subject: subject object: object [

	^ [ self typecheck: aRMDSyntaxNode subject: subject object: object ]
		  on: RMDUnresolvedPlaceholderError
		  do: [ :ex | ex resume: RMDType any ]
]

{ #category : #'context controls' }
RMDTypechecker >> withSubject: subject object: object do: aBlock [

	| subjectDefinition objectIdentifier objectDefinition |
	subject isString
		ifTrue: [ 
			subjectDefinition := self
				                     agentDefinitionAt: subject
				                     ifAbsent: [ nil ] ]
		ifFalse: [ subjectDefinition := subject ].
	object isString
		ifTrue: [ 
			objectDefinition := self
				                    agentDefinitionAt: object
				                    ifAbsent: [ nil ].
			objectIdentifier := object ]
		ifFalse: [ 
			objectDefinition := object.
			objectIdentifier := object ifNotNil: #identifier ].
	^ self
		  withContext: (RMDTypecheckContext new
				   patchDefinition: self patchDefinition;
				   worldDefinition: self worldDefinition;
				   subjectDefinition: subjectDefinition;
				   object: objectIdentifier definition: objectDefinition;
				   yourself)
		  do: aBlock
]
