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
	subjectSpecies := subjectIdentifier = 'Cell'
		                  ifTrue: [ aRMDInterpreter cellDefinition ]
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
		                    xdivisions:
		                    (aRMDInterpreter north / range numeric) ceiling
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
		individualsOf: subjectSpecies
		do: [ :subjectAnimat :subjectLifehistory | 
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
				do: [ :objectLifehistory | 
					aRMDInterpreter
						setupRandomForIndividual: subjectAnimat
						and: objectLifehistory last
						task: self;
						withActionContextWithIndividual: subjectLifehistory
						species: subjectSpecies
						object: objectLifehistory
						species: objectSpecies
						do: [ 
							(self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithNearestObjectsIn: aRMDInterpreter [

	| subjectSpecies objectSpecies |
	subjectSpecies := subjectIdentifier = 'Cell'
		                  ifTrue: [ aRMDInterpreter cellDefinition ]
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
	aRMDInterpreter
		individualsOf: subjectSpecies
		do: [ :subjectAnimat :subjectLifehistory | 
			| subjectX subjectY minSquareD nearestObjectLifehistory |
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
			nearestObjectLifehistory := nil.
			minSquareD := Float infinity.
			aRMDInterpreter
				individualsOf: objectSpecies
				do: [ :objectAnimat :objectLifehistory | 
					aRMDInterpreter
						withObserverContextWithSubject: objectAnimat
						species: objectSpecies
						do: [ 
							| x y squareD |
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
							squareD := (x - subjectX) squared + (y - subjectY) squared.
							squareD < minSquareD ifTrue: [ 
								minSquareD := squareD.
								nearestObjectLifehistory := objectLifehistory ] ] ].

			aRMDInterpreter
				setupRandomForIndividual: subjectAnimat
				and: nearestObjectLifehistory last
				task: self;
				withActionContextWithIndividual: subjectLifehistory
				species: subjectSpecies
				object: nearestObjectLifehistory
				species: objectSpecies
				do: [ (self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithoutObjectIn: aRMDInterpreter [

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
	aRMDInterpreter individualsOf: species do: [ :animat :lifehistory | 
		aRMDInterpreter
			setupRandomForIndividual: animat task: self;
			withActionContextWithIndividual: lifehistory
			species: species
			do: [ (self actionWith: aRMDInterpreter) evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForTask: self)
		do: [ (self actionWith: aRMDInterpreter) typecheckIn: aRMDInterpreter ]
]
