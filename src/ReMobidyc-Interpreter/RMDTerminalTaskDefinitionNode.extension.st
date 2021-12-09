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
