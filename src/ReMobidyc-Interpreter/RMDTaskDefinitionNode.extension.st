Extension { #name : #RMDTaskDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalIn: aRMDInterpreter [
	| species |
	species := subjectIdentifier = 'Cell'
		ifTrue: [ aRMDInterpreter cellDefinition ]
		ifFalse: [ subjectIdentifier = 'World'
				ifTrue: [ aRMDInterpreter worldDefinition ]
				ifFalse: [ aRMDInterpreter
						animatDefinitionAt: subjectIdentifier
						ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ] ] ].
	self hasObject
		ifTrue: [ self shouldBeImplemented ]
		ifFalse: [ aRMDInterpreter
				individualsOf: species
				do: [ :animat | 
					aRMDInterpreter
						withActionContextWithIndividual: animat
						species: species
						do: [ (self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [
	(self actionWith: aRMDInterpreter) typecheckIn: aRMDInterpreter
]
