Extension { #name : 'RMDTaskDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalIn: aRMDInterpreter [

	enabled ifTrue: [
		[
		self hasObject
			ifTrue: [
				nearest
					ifTrue: [ self evalWithNearestObjectIn: aRMDInterpreter ]
					ifFalse: [ self evalWithAllObjectsIn: aRMDInterpreter ] ]
			ifFalse: [ self evalWithoutObjectIn: aRMDInterpreter ] ]
			on: RMDSemanticError
			do: [ :ex | ex signalWithScope: self ] ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithAllObjectsIn: aRMDInterpreter [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace |
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	taskHash := aRMDInterpreter taskHashFor: self.
	subjectAgent := aRMDInterpreter simulationModel
		                agentDefinitionAt: subjectIdentifier
		                ifAbsent: [
		                ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	objectAgent := aRMDInterpreter simulationModel
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [
		               ^ RMDUndefinedAnimatError signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter simulationModel north
		                    height: aRMDInterpreter simulationModel east
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

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithNearestObjectIn: aRMDInterpreter [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace |
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	taskHash := aRMDInterpreter taskHashFor: self.
	subjectAgent := aRMDInterpreter simulationModel
		                agentDefinitionAt: subjectIdentifier
		                ifAbsent: [
		                ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	objectAgent := aRMDInterpreter simulationModel
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [
		               ^ RMDUndefinedAnimatError signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter simulationModel north
		                    height: aRMDInterpreter simulationModel east
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

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithoutObjectIn: aRMDInterpreter [

	| agent taskHash specializedAction |
	agent := aRMDInterpreter simulationModel
		         agentDefinitionAt: subjectIdentifier
		         ifAbsent: [
		         ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	taskHash := aRMDInterpreter taskHashFor: self.
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	aRMDInterpreter individualsOf: agent do: [ :animat |
		aRMDInterpreter
			withActionContextWith: specializedAction
			subject: animat
			definition: agent
			taskHash: taskHash
			do: [ specializedAction evalIn: aRMDInterpreter ] ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [

	[ 
	(self actionWith: aRMDInterpreter simulationModel) typecheckIn:
		aRMDInterpreter ]
		on: RMDSemanticError
		do: [ :ex | ex signalWithScope: self ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> validate: anInteger in: aRMDInterpreter do: aBlock [

	self hasObject
		ifTrue: [
			nearest
				ifTrue: [
					self
						validate: anInteger
						withNearestObjectIn: aRMDInterpreter
						do: aBlock ]
				ifFalse: [  ] ]
		ifFalse: [
			self
				validateWithoutObject: anInteger
				in: aRMDInterpreter
				do: aBlock ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> validate: anInteger withAllObjectsIn: aRMDInterpreter do: aBlock [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace subjectAnimat subjectX subjectY |
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	taskHash := aRMDInterpreter taskHashFor: self.
	subjectAgent := aRMDInterpreter simulationModel
		                agentDefinitionAt: subjectIdentifier
		                ifAbsent: [
		                ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	objectAgent := aRMDInterpreter simulationModel
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [
		               ^ RMDUndefinedAnimatError signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter simulationModel north
		                    height: aRMDInterpreter simulationModel east
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
	subjectAnimat := anInteger.
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
			| traceableAction |
			traceableAction := specializedAction beTraceable.
			aRMDInterpreter simulationModel typechecker
				typecheck: traceableAction
				subject: subjectAgent
				object: objectAgent.
			aRMDInterpreter
				withActionContextWith: specializedAction
				subject: subjectAnimat
				definition: subjectAgent
				object: objectAnimat
				definition: objectAgent
				taskHash: taskHash
				do: [ :interpreter :context |
					traceableAction evalIn: interpreter.
					aBlock value: context ] ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> validate: anInteger withNearestObjectIn: aRMDInterpreter do: aBlock [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace subjectAnimat subjectX subjectY |
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	taskHash := aRMDInterpreter taskHashFor: self.
	subjectAgent := aRMDInterpreter simulationModel
		                agentDefinitionAt: subjectIdentifier
		                ifAbsent: [
		                ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	objectAgent := aRMDInterpreter simulationModel
		               animatDefinitionAt: objectIdentifier
		               ifAbsent: [
		               ^ RMDUndefinedAnimatError signal: objectIdentifier ].
	interactionSpace := RMDInteractionSpace
		                    width: aRMDInterpreter simulationModel north
		                    height: aRMDInterpreter simulationModel east
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
	subjectAnimat := anInteger.
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
			| traceableAction |
			traceableAction := specializedAction beTraceable.
			aRMDInterpreter simulationModel typechecker
				typecheck: traceableAction
				subject: subjectAgent
				object: objectAgent.
			aRMDInterpreter
				withActionContextWith: traceableAction
				subject: subjectAnimat
				definition: subjectAgent
				object: objectAnimat
				definition: objectAgent
				taskHash: taskHash
				do: [ :interpreter :context |
					traceableAction evalIn: interpreter.
					aBlock value: context ] ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> validateWithoutObject: anInteger in: aRMDInterpreter do: aBlock [

	| traceableAction taskHash subjectAgent |
	traceableAction := (self actionWith: aRMDInterpreter simulationModel)
		                   beTraceable.
	taskHash := aRMDInterpreter taskHashFor: self.
	subjectAgent := aRMDInterpreter simulationModel
		                agentDefinitionAt: subjectIdentifier
		                ifAbsent: [
		                ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	aRMDInterpreter simulationModel typechecker
		typecheck: traceableAction
		subject: subjectAgent
		object: nil.
	aRMDInterpreter
		withActionContextWith: traceableAction
		subject: anInteger
		definition: subjectAgent
		taskHash: taskHash
		do: [ :interpreter :context |
			traceableAction evalIn: interpreter.
			aBlock value: context ]
]
