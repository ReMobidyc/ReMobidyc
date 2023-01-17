Extension { #name : #RMDTaskDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalIn: aRMDInterpreter [

	[ 
	self hasObject
		ifTrue: [ 
			nearest
				ifTrue: [ self evalWithNearestObjectsIn: aRMDInterpreter ]
				ifFalse: [ self evalWithAllObjectsIn: aRMDInterpreter ] ]
		ifFalse: [ self evalWithoutObjectIn: aRMDInterpreter ] ]
		on: RMDSemanticError
		do: [ :ex | ex signalWithScope: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithAllObjectsIn: aRMDInterpreter [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace |
	specializedAction := self actionWith: aRMDInterpreter.
	taskHash := aRMDInterpreter taskDefinitions indexOf: self.
	subjectAgent := aRMDInterpreter
		                agentDefinitionAt: subjectIdentifier
		                ifAbsent: [ 
		                ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	objectAgent := aRMDInterpreter
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [ 
		               ^ RMDUndefinedAnimatError signal: objectIdentifier ].
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
				x := aRMDInterpreter my: 'x'.
				y := aRMDInterpreter my: 'y'.
				interactionSpace add: objectAnimat x: x y: y ] ].
	aRMDInterpreter individualsOf: subjectAgent do: [ :subjectAnimat | 
		| subjectX subjectY |
		aRMDInterpreter
			withObserverContextWithSubject: subjectAnimat
			definition: subjectAgent
			do: [ 
				subjectX := aRMDInterpreter my: 'x'.
				subjectY := aRMDInterpreter my: 'y' ].
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
	subjectAgent := aRMDInterpreter
		                agentDefinitionAt: subjectIdentifier
		                ifAbsent: [ 
		                ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	objectAgent := aRMDInterpreter
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [ 
		               ^ RMDUndefinedAnimatError signal: objectIdentifier ].
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
				x := aRMDInterpreter my: 'x'.
				y := aRMDInterpreter my: 'y'.
				interactionSpace add: objectAnimat x: x y: y ] ].
	aRMDInterpreter individualsOf: subjectAgent do: [ :subjectAnimat | 
		| subjectX subjectY |
		aRMDInterpreter
			withObserverContextWithSubject: subjectAnimat
			definition: subjectAgent
			do: [ 
				subjectX := aRMDInterpreter my: 'x'.
				subjectY := aRMDInterpreter my: 'y' ].
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

	| agent taskHash |
	agent := aRMDInterpreter
		         agentDefinitionAt: subjectIdentifier
		         ifAbsent: [ 
		         ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	taskHash := aRMDInterpreter taskDefinitions indexOf: self.
	aRMDInterpreter individualsOf: agent do: [ :animat | 
		| specializedAction |
		specializedAction := self actionWith: aRMDInterpreter.
		aRMDInterpreter
			withActionContextWith: specializedAction
			subject: animat
			definition: agent
			taskHash: taskHash
			do: [ specializedAction evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [

	[ (self actionWith: aRMDInterpreter) typecheckIn: aRMDInterpreter ]
		on: RMDSemanticError
		do: [ :ex | ex signalWithScope: self ]
]
