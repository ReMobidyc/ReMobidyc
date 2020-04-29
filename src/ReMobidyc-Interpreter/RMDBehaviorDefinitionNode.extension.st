Extension { #name : #RMDBehaviorDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBehaviorDefinitionNode >> evalIn: aRMDInterpreter [
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
						setActionContextWithIndividual: animat
						species: species.
					(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ]
]
