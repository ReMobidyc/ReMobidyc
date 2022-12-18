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
RMDTypechecker >> newTypecheckContextForTask: aRMDTaskDefinitionNode [

	| newContext |
	newContext := self newTypecheckingContextWithSubject:
		              aRMDTaskDefinitionNode subjectIdentifier.
	aRMDTaskDefinitionNode hasObject ifTrue: [ 
		| object |
		object := aRMDTaskDefinitionNode objectIdentifier.
		newContext object: object definition: (self
				 animatDefinitionAt: object
				 ifAbsent: [ 
				 ^ RMDUndefinedAnimatError signal: aRMDTaskDefinitionNode ]) ].
	newContext action: (aRMDTaskDefinitionNode actionWith: self).
	^ newContext
]

{ #category : #private }
RMDTypechecker >> newTypecheckContextWithSubjectDefinition: aRMDAgentDefinition [

	^ self newTypecheckingContext
		  subjectDefinition: aRMDAgentDefinition;
		  yourself
]

{ #category : #private }
RMDTypechecker >> newTypecheckingContext [
	^ RMDTypecheckContext new
		patchDefinition: self patchDefinition;
		worldDefinition: self worldDefinition;
		yourself
]

{ #category : #private }
RMDTypechecker >> newTypecheckingContextWithSubject: aString [

	^ self newTypecheckContextWithSubjectDefinition: (aString = 'World'
			   ifTrue: [ simulationModel worldDefinition ]
			   ifFalse: [ 
				   aString = 'Patch'
					   ifTrue: [ simulationModel patchDefinition ]
					   ifFalse: [ 
						   simulationModel
							   animatDefinitionAt: aString
							   ifAbsent: [ ^ RMDUndefinedAnimatError signal: aString ] ] ])
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

	^ aRMDSyntaxNode typecheckIn: self
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
		withSubjectDefinition: simulationModel worldDefinition
		do: [ simulationModel worldInitializer typecheckIn: self ].
	self
		withSubjectDefinition: simulationModel patchDefinition
		do: [ simulationModel patchInitializer typecheckIn: self ].
	simulationModel animatInitializersDo: [ :animatInitializer | 
		self
			withSubject: animatInitializer animat
			do: [ animatInitializer typecheckIn: self ] ]
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckTasks [

	simulationModel taskDefinitionsDo: [ :taskDefinition | 
		taskDefinition typecheckIn: self ]
]

{ #category : #'type checking' }
RMDTypechecker >> weakTypecheck: aRMDSyntaxNode [

	^ [ self typecheck: aRMDSyntaxNode ]
		  on: RMDUnresolvedPlaceholderError
		  do: [ :ex | ex resume: RMDType any ]
]

{ #category : #'context controls' }
RMDTypechecker >> withSubject: aString do: aBlock [

	^ self
		  withContext: (self newTypecheckingContextWithSubject: aString)
		  do: aBlock
]

{ #category : #'context controls' }
RMDTypechecker >> withSubjectDefinition: aRMDAgentDefinitionNode do: aBlock [

	^ self
		  withContext:
		  (self newTypecheckContextWithSubjectDefinition:
			   aRMDAgentDefinitionNode)
		  do: aBlock
]

{ #category : #'context controls' }
RMDTypechecker >> withSubjectDefinition: aRMDAgentDefinitionNode object: aString definition: aRMDAnimatDefinitionNode do: aBlock [

	^ self
		  withContext: ((self newTypecheckContextWithSubjectDefinition:
					    aRMDAgentDefinitionNode)
				   object: aString definition: aRMDAnimatDefinitionNode;
				   yourself)
		  do: aBlock
]
