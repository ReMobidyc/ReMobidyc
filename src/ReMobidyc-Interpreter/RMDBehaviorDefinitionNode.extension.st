Extension { #name : #RMDBehaviorDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBehaviorDefinitionNode >> evalIn: aRMDInterpreter [
	| species |
	species := aRMDInterpreter
		animatDefinitionAt: subjectIdentifier
		ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ].
	self hasObject
		ifTrue: [ self shouldBeImplemented ]
		ifFalse: [ aRMDInterpreter
				individualsOf: species
				do: [ :animat | 
					aRMDInterpreter setActionContextWithIndividual: animat species: animat.
					(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ]
]
