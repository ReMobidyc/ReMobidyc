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
		ifTrue: [ 
			| objectSpecies interactionSpace |
			objectSpecies := aRMDInterpreter
				                 animatDefinitionAt: objectIdentifier
				                 ifAbsent: [ 
				                 ^ KeyNotFound signal: objectIdentifier ].
			interactionSpace := RMDInteractionSpace
				                    xdivisions:
				                    (aRMDInterpreter north / range numeric)
					                    ceiling
				                    yDividions:
				                    (aRMDInterpreter east / range numeric) ceiling
				                    range: range numeric.
			aRMDInterpreter
				individualsOf: objectSpecies
				do: [ :objectAnimat :objectLifehistory | 
					aRMDInterpreter
						withObserverContextWithSubject: objectAnimat
						species: objectSpecies
						do: [ 
							| x y |
							x := aRMDInterpreter
								     readVariable: 'x'
								     agent: nil
								     ifAbsent: [ 
								     ^ (RMDUnresolvedReferenceError on: self) signal ].
							y := aRMDInterpreter
								     readVariable: 'y'
								     agent: nil
								     ifAbsent: [ 
								     ^ (RMDUnresolvedReferenceError on: self) signal ].
							interactionSpace add: objectLifehistory x: x y: y ] ].
			aRMDInterpreter
				individualsOf: species
				do: [ :subjectAnimat :subjectLifehistory | 
					| subjectX subjectY |
					aRMDInterpreter
						withObserverContextWithSubject: subjectAnimat
						species: species
						do: [ 
							subjectX := aRMDInterpreter
								            readVariable: 'x'
								            agent: nil
								            ifAbsent: [ 
								            ^ (RMDUnresolvedReferenceError on: self) signal ].
							subjectY := aRMDInterpreter
								            readVariable: 'y'
								            agent: nil
								            ifAbsent: [ 
								            ^ (RMDUnresolvedReferenceError on: self) signal ] ].
					interactionSpace
						animatsAroundX: subjectX
						y: subjectY
						do: [ :objectLifehistory | 
							aRMDInterpreter
								setupRandomForIndividual: subjectAnimat
								and: objectLifehistory last
								task: self;
								withActionContextWithIndividual: subjectLifehistory
								species: species
								object: objectLifehistory
								species: objectSpecies
								do: [ 
									(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ] ] ]
		ifFalse: [ 
			aRMDInterpreter
				individualsOf: species
				do: [ :animat :lifehistory | 
					aRMDInterpreter
						setupRandomForIndividual: animat task: self;
						withActionContextWithIndividual: lifehistory
						species: species
						do: [ 
							(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForTask: self)
		do: [ (self actionWith: aRMDInterpreter) typecheckIn: aRMDInterpreter ]
]
