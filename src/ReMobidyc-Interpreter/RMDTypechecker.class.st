Class {
	#name : #RMDTypechecker,
	#superclass : #RMDAbstractInterpreter,
	#instVars : [
		'libraries'
	],
	#category : #'ReMobidyc-Interpreter-Core'
}

{ #category : #'accessing - libraries' }
RMDTypechecker >> addLibraries: aCollectionOfDictionary [
	libraries addAll: aCollectionOfDictionary
]

{ #category : #'accessing - libraries' }
RMDTypechecker >> addLibrary: aDictionary [
	libraries add: aDictionary
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

{ #category : #'accessing - libraries' }
RMDTypechecker >> functionAt: aString ifAbsent: errorBlock [
	libraries
		do:
			[ :library | library at: aString ifPresent: [ :function | ^ function ] ].
	^ errorBlock value
]

{ #category : #initialization }
RMDTypechecker >> initialize [

	super initialize.
	libraries := OrderedCollection with: self standardLibrary
]

{ #category : #testing }
RMDTypechecker >> isTypechecker [

	^ true
]

{ #category : #accessing }
RMDTypechecker >> kindName [

	^ 'type checker'
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

{ #category : #'accessing - libraries' }
RMDTypechecker >> standardLibrary [
	^ self class standardLibrary 
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
RMDTypechecker >> typecheckAgentDefinitions [

	self
		typecheck: simulationModel worldDefinition
		subject: simulationModel worldDefinition.
	self
		typecheck: simulationModel patchDefinition
		subject: simulationModel patchDefinition.

	simulationModel animatDefinitionsDo: [ :animatDefinition | 
		self typecheck: animatDefinition subject: animatDefinition agentName ]
]

{ #category : #'type checking' }
RMDTypechecker >> typecheckAll [

	self
		typecheckAgentDefinitions;
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
			subjectDefinition := self simulationModel
				                     agentDefinitionAt: subject
				                     ifAbsent: [ nil ] ]
		ifFalse: [ subjectDefinition := subject ].
	object isString
		ifTrue: [ 
			objectDefinition := self simulationModel
				                    agentDefinitionAt: object
				                    ifAbsent: [ nil ].
			objectIdentifier := object ]
		ifFalse: [ 
			objectDefinition := object.
			objectIdentifier := object ifNotNil: #identifier ].
	^ self
		  withContext: (RMDTypecheckContext new
				   patchDefinition: self simulationModel patchDefinition;
				   worldDefinition: self simulationModel worldDefinition;
				   subjectDefinition: subjectDefinition;
				   object: objectIdentifier definition: objectDefinition;
				   yourself)
		  do: aBlock
]
