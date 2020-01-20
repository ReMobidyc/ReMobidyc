Extension { #name : #RMDBehaviorDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBehaviorDefinitionNode >> evalIn: aRMDInterpreter [
	| action animat |
	animat := aRMDInterpreter
		animatDefinitionAt: subjectIdentifier
		ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ].
	action := aRMDInterpreter
		actionDefinitionAt: scriptIdentifier
		ifAbsent: [ ^ KeyNotFound signal: scriptIdentifier ].
	self hasObject
		ifTrue: [ self shouldBeImplemented ]
		ifFalse: [ aRMDInterpreter
				individualsOf: animat
				do: [ :animatId | 
					aRMDInterpreter
						setContextWithIndividual: animatId
						species: animat
						propertyBindMap: propertyBinds.
					action evalIn: aRMDInterpreter ] ]
]
