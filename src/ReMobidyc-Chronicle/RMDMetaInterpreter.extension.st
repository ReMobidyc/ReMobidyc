Extension { #name : 'RMDMetaInterpreter' }

{ #category : '*ReMobidyc-Chronicle' }
RMDMetaInterpreter >> recordInChronicle [

	^ self modelPath ifNotNil: [ :modelPath |
		  | basename chronicleModel |
		  basename := modelPath basename.
		  chronicleModel := self simulationModel recordInChronicle: basename.
		  chronicleModel hideMetadata addTag: 'run'.
		  chronicleModel hideSave.
		  chronicleModel ]
]
