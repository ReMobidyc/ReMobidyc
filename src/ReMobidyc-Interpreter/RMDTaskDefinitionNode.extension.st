Extension { #name : #RMDTaskDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalIn: aRMDInterpreter [

	enabled ifTrue: [
		[
		self hasObject
			ifTrue: [
				nearest
					ifTrue: [ self evalWithNearestObjectsIn: aRMDInterpreter ]
					ifFalse: [ self evalWithAllObjectsIn: aRMDInterpreter ] ]
			ifFalse: [ self evalWithoutObjectIn: aRMDInterpreter ] ]
			on: RMDSemanticError
			do: [ :ex | ex signalWithScope: self ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithAllObjectsIn: aRMDInterpreter [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace |
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	taskHash := aRMDInterpreter simulationModel taskDefinitions indexOf:
		            self.
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

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithNearestObjectsIn: aRMDInterpreter [

	| specializedAction taskHash subjectAgent objectAgent interactionSpace |
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	taskHash := aRMDInterpreter simulationModel taskDefinitions indexOf:
		            self.
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

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> evalWithoutObjectIn: aRMDInterpreter [

	| agent taskHash specializedAction |
	agent := aRMDInterpreter simulationModel
		         agentDefinitionAt: subjectIdentifier
		         ifAbsent: [ 
		         ^ RMDUndefinedAnimatError signal: subjectIdentifier ].
	taskHash := aRMDInterpreter simulationModel taskDefinitions indexOf:
		            self.
	specializedAction := self actionWith: aRMDInterpreter simulationModel.
	aRMDInterpreter individualsOf: agent do: [ :animat | 
		aRMDInterpreter
			withActionContextWith: specializedAction
			subject: animat
			definition: agent
			taskHash: taskHash
			do: [ specializedAction evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDTaskDefinitionNode >> typecheckIn: aRMDInterpreter [

	[ 
	(self actionWith: aRMDInterpreter simulationModel) typecheckIn:
		aRMDInterpreter ]
		on: RMDSemanticError
		do: [ :ex | ex signalWithScope: self ]
]
