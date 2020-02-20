Extension { #name : #RMDBehaviorDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBehaviorDefinitionNode >> evalIn: aRMDInterpreter [
	| action species |
	species := aRMDInterpreter
		animatDefinitionAt: subjectIdentifier
		ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ].
	action := aRMDInterpreter
		actionDefinitionAt: actionIdentifier
		ifAbsent: [ ^ KeyNotFound signal: actionIdentifier ].
	self hasObject
		ifTrue: [ self shouldBeImplemented ]
		ifFalse: [ aRMDInterpreter
				individualsOf: species
				do: [ :animat | 
					aRMDInterpreter
						setActionContextWithIndividual: animat
						species: animat
						propertyBindMap: propertyBinds.
					action evalIn: aRMDInterpreter ] ]
]
