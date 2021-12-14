Extension { #name : #RMDTerminalTaskDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTerminalTaskDefinitionNode >> evalIn: aRMDInterpreter [

	| species |
	species := aRMDInterpreter
		           animatDefinitionAt: subjectIdentifier
		           ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ].
	aRMDInterpreter individualsOf: species do: [ :animat | 
		aRMDInterpreter
			setupRandomForIndividual: animat task: self;
			withActionContextWithIndividual: animat
			species: species
			do: [ self evalIndividualIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTerminalTaskDefinitionNode >> evalIndividualIn: aRMDInterpreter [

	aRMDInterpreter context action: self.
	(guard evalIn: aRMDInterpreter) ifTrue: [ 
		aRMDInterpreter terminate: nil ].
	^ nil
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTerminalTaskDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForTask: self)
		do: [ 
			utilityDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ].
			guard ifNotNil: [ guard typecheckIn: aRMDInterpreter ].
			propertyDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ] ]
]
