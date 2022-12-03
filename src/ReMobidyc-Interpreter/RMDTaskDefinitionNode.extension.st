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

	| specializedAction taskHash subjectAgent objectAgent interactionSpace |
	specializedAction := self actionWith: aRMDInterpreter.
	taskHash := aRMDInterpreter taskDefinitions indexOf: self.
	subjectAgent := subjectIdentifier = 'Patch'
		                ifTrue: [ aRMDInterpreter patchDefinition ]
		                ifFalse: [ 
			                subjectIdentifier = 'World'
				                ifTrue: [ aRMDInterpreter worldDefinition ]
				                ifFalse: [ 
					                aRMDInterpreter
						                animatDefinitionAt: subjectIdentifier
						                ifAbsent: [ 
						                ^ KeyNotFound signal: subjectIdentifier ] ] ].
	objectAgent := aRMDInterpreter
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [ ^ KeyNotFound signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter north
		                    height: aRMDInterpreter east
		                    range: range numeric.
	aRMDInterpreter individualsOf: objectAgent do: [ :objectAnimat | 
		aRMDInterpreter
			withObserverContextWithSubject: objectAnimat
			definition: objectAgent
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
	aRMDInterpreter individualsOf: subjectAgent do: [ :subjectAnimat | 
		| subjectX subjectY |
		aRMDInterpreter
			withObserverContextWithSubject: subjectAnimat
			definition: subjectAgent
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
					withActionContextWith: specializedAction
					subject: subjectAnimat
					definition: subjectAgent
					object: objectAnimat
					definition: objectAgent
					taskHash: taskHash
					do: [ specializedAction evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithNearestObjectsIn: aRMDInterpreter [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace |
	specializedAction := self actionWith: aRMDInterpreter.
	taskHash := aRMDInterpreter taskDefinitions indexOf: self.
	subjectAgent := subjectIdentifier = 'Patch'
		                ifTrue: [ aRMDInterpreter patchDefinition ]
		                ifFalse: [ 
			                subjectIdentifier = 'World'
				                ifTrue: [ aRMDInterpreter worldDefinition ]
				                ifFalse: [ 
					                aRMDInterpreter
						                animatDefinitionAt: subjectIdentifier
						                ifAbsent: [ 
						                ^ KeyNotFound signal: subjectIdentifier ] ] ].
	objectAgent := aRMDInterpreter
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [ ^ KeyNotFound signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter north
		                    height: aRMDInterpreter east
		                    range: range numeric.
	range numeric.
	aRMDInterpreter individualsOf: objectAgent do: [ :objectAnimat | 
		aRMDInterpreter
			withObserverContextWithSubject: objectAnimat
			definition: objectAgent
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
	aRMDInterpreter individualsOf: subjectAgent do: [ :subjectAnimat | 
		| subjectX subjectY |
		aRMDInterpreter
			withObserverContextWithSubject: subjectAnimat
			definition: subjectAgent
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
					withActionContextWith: specializedAction
					subject: subjectAnimat
					definition: subjectAgent
					object: objectAnimat
					definition: objectAgent
					taskHash: taskHash
					do: [ specializedAction evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithoutObjectIn: aRMDInterpreter [

	| agent |
	agent := subjectIdentifier = 'Patch'
		         ifTrue: [ aRMDInterpreter patchDefinition ]
		         ifFalse: [ 
			         subjectIdentifier = 'World'
				         ifTrue: [ aRMDInterpreter worldDefinition ]
				         ifFalse: [ 
					         aRMDInterpreter
						         animatDefinitionAt: subjectIdentifier
						         ifAbsent: [ ^ KeyNotFound signal: subjectIdentifier ] ] ].
	aRMDInterpreter individualsOf: agent do: [ :animat | 
		| specializedAction |
		specializedAction := self actionWith: aRMDInterpreter.
		aRMDInterpreter
			withActionContextWith: specializedAction
			subject: animat
			definition: agent
			taskHash: (aRMDInterpreter taskDefinitions indexOf: self)
			do: [ specializedAction evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: (aRMDInterpreter newTypecheckContextForTask: self)
		do: [ (self actionWith: aRMDInterpreter) typecheckIn: aRMDInterpreter ]
]
