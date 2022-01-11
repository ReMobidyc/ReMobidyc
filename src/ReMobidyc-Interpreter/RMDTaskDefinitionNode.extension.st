Extension { #name : #RMDTaskDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalIn: aRMDInterpreter [

	| species |
	species := subjectIdentifier = 'Cell'
		           ifTrue: [ aRMDInterpreter cellDefinition ]
		           ifFalse: [ 
			           subjectIdentifier = 'World'
				           ifTrue: [ aRMDInterpreter worldDefinition ]
				           ifFalse: [ 
					           aRMDInterpreter
						           animatDefinitionAt: subjectIdentifier
						           ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ] ] ].
	self hasObject
		ifTrue: [ self shouldBeImplemented ]
		ifFalse: [ 
			aRMDInterpreter individualsOf: species do: [ :animat :lifehistory | 
				aRMDInterpreter
					setupRandomForIndividual: animat task: self;
					withActionContextWithIndividual: lifehistory
					species: species
					do: [ (self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForTask: self)
		do: [ (self actionWith: aRMDInterpreter) typecheckIn: aRMDInterpreter ]
]
