Extension { #name : #RMDTaskDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalIn: aRMDInterpreter [

	self hasObject
		ifTrue: [ 
			nearest
				ifTrue: [ self evalWithNearestObjectsIn: aRMDInterpreter ]
				ifFalse: [ self evalWithAllObjectsIn: aRMDInterpreter ] ]
		ifFalse: [ self evalWithoutObjectIn: aRMDInterpreter ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithAllObjectsIn: aRMDInterpreter [

	| subjectSpecies objectSpecies interactionSpace |
	subjectSpecies := subjectIdentifier = 'Patch'
		                  ifTrue: [ aRMDInterpreter patchDefinition ]
		                  ifFalse: [ 
			                  subjectIdentifier = 'World'
				                  ifTrue: [ aRMDInterpreter worldDefinition ]
				                  ifFalse: [ 
					                  aRMDInterpreter
						                  animatDefinitionAt: subjectIdentifier
						                  ifAbsent: [ 
						                  ^ KeyNotFound signal: subjectIdentifier ] ] ].
	objectSpecies := aRMDInterpreter
		                 animatDefinitionAt: objectIdentifier
		                 ifAbsent: [ ^ KeyNotFound signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter north
		                    height: aRMDInterpreter east
		                    range: range numeric.
	aRMDInterpreter individualsOf: objectSpecies do: [ :objectAnimat | 
		aRMDInterpreter
			withObserverContextWithSubject: objectAnimat
			species: objectSpecies
			do: [ 
				| x y |
				x := aRMDInterpreter
					     readVariable: 'x'
					     agent: nil
					     ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ].
				y := aRMDInterpreter
					     readVariable: 'y'
					     agent: nil
					     ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ].
				interactionSpace add: objectAnimat x: x y: y ] ].
	aRMDInterpreter
		individualsOf: subjectSpecies
		do: [ :subjectAnimat | 
			| subjectX subjectY |
			aRMDInterpreter
				withObserverContextWithSubject: subjectAnimat
				species: subjectSpecies
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
				do: [ :objectAnimat | 
					aRMDInterpreter
						withActionContextWithIndividual: subjectAnimat
						species: subjectSpecies
						object: objectAnimat
						species: objectSpecies
						do: [ 
							aRMDInterpreter
								setupRandomForIndividual: subjectAnimat
								and: objectAnimat
								task: self.
							(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithNearestObjectsIn: aRMDInterpreter [

	| subjectSpecies objectSpecies interactionSpace |
	subjectSpecies := subjectIdentifier = 'Patch'
		                  ifTrue: [ aRMDInterpreter patchDefinition ]
		                  ifFalse: [ 
			                  subjectIdentifier = 'World'
				                  ifTrue: [ aRMDInterpreter worldDefinition ]
				                  ifFalse: [ 
					                  aRMDInterpreter
						                  animatDefinitionAt: subjectIdentifier
						                  ifAbsent: [ 
						                  ^ KeyNotFound signal: subjectIdentifier ] ] ].
	objectSpecies := aRMDInterpreter
		                 animatDefinitionAt: objectIdentifier
		                 ifAbsent: [ ^ KeyNotFound signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter north
		                    height: aRMDInterpreter east
		                    range: range numeric.
	range numeric.
	aRMDInterpreter individualsOf: objectSpecies do: [ :objectAnimat | 
		aRMDInterpreter
			withObserverContextWithSubject: objectAnimat
			species: objectSpecies
			do: [ 
				| x y |
				x := aRMDInterpreter
					     readVariable: 'x'
					     agent: nil
					     ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ].
				y := aRMDInterpreter
					     readVariable: 'y'
					     agent: nil
					     ifAbsent: [ ^ (RMDUnresolvedReferenceError on: self) signal ].
				interactionSpace add: objectAnimat x: x y: y ] ].
	aRMDInterpreter
		individualsOf: subjectSpecies
		do: [ :subjectAnimat | 
			| subjectX subjectY |
			aRMDInterpreter
				withObserverContextWithSubject: subjectAnimat
				species: subjectSpecies
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
				nearestAnimatAroundX: subjectX
				y: subjectY
				do: [ :objectAnimat | 
					aRMDInterpreter
						withActionContextWithIndividual: subjectAnimat
						species: subjectSpecies
						object: objectAnimat
						species: objectSpecies
						do: [ 
							aRMDInterpreter
								setupRandomForIndividual: subjectAnimat
								and: objectAnimat
								task: self.
							(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithoutObjectIn: aRMDInterpreter [

	| species |
	species := subjectIdentifier = 'Patch'
		           ifTrue: [ aRMDInterpreter patchDefinition ]
		           ifFalse: [ 
			           subjectIdentifier = 'World'
				           ifTrue: [ aRMDInterpreter worldDefinition ]
				           ifFalse: [ 
					           aRMDInterpreter
						           animatDefinitionAt: subjectIdentifier
						           ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ] ] ].
	aRMDInterpreter individualsOf: species do: [ :animat | 
		aRMDInterpreter
			withActionContextWithIndividual: animat
			species: species
			do: [ 
				aRMDInterpreter setupRandomForIndividual: animat task: self.
				(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForTask: self)
		do: [ (self actionWith: aRMDInterpreter) typecheckIn: aRMDInterpreter ]
]
