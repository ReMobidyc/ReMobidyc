Class {
	#name : 'RMDColorTriangleTableColumn',
	#superclass : 'SpImageTableColumn',
	#instVars : [
		'subjectBlock',
		'objectBlock',
		'utilitiesBlock',
		'simulationModelBlock',
		'namecrashBlock',
		'permitsUnresolvedAttributeReference'
	],
	#classVars : [
		'GreenTriangleIcon',
		'RedTriangleIcon',
		'YellowTriangleIcon'
	],
	#category : 'ReMobidyc-Spec2-Columns',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Columns'
}

{ #category : 'icons' }
RMDColorTriangleTableColumn class >> greenTriangleIcon [

	^ GreenTriangleIcon ifNil: [
		  | form canvas |
		  form := Form extent: 11 @ 11 depth: 32.
		  canvas := form getCanvas.
		  canvas fillColor: Color transparent.
		  canvas
			  drawPolygon: {
					  (2 @ 2).
					  (10 @ 5).
					  (2 @ 9) }
			  color: Color green
			  borderWidth: 1
			  borderColor: Color darkGray.
		  GreenTriangleIcon := form ]
]

{ #category : 'icons' }
RMDColorTriangleTableColumn class >> redTriangleIcon [

	^ RedTriangleIcon ifNil: [
		  | form canvas |
		  form := Form extent: 11 @ 11 depth: 32.
		  canvas := form getCanvas.
		  canvas fillColor: Color transparent.
		  canvas
			  drawPolygon: {
					  (1 @ 1).
					  (10 @ 5).
					  (1 @ 10) }
			  color: Color red
			  borderWidth: 1
			  borderColor: Color lightGray.
		  RedTriangleIcon := form ]
]

{ #category : 'instance creation' }
RMDColorTriangleTableColumn class >> subjectBlock: agentNameBlock objectBlock: objectBlock utilitiesBlock: utilitiesBlock simulationModel: simulationModelBlock [

	^ self new
		  subjectBlock: agentNameBlock;
		  objectBlock: objectBlock;
		  utilitiesBlock: utilitiesBlock;
		  simulationModelBlock: simulationModelBlock;
		  yourself
]

{ #category : 'instance creation' }
RMDColorTriangleTableColumn class >> subjectBlock: agentNameBlock utilitiesBlock: utilitiesBlock simulationModel: simulationModelBlock [

	^ self new
		  subjectBlock: agentNameBlock;
		  utilitiesBlock: utilitiesBlock;
		  simulationModelBlock: simulationModelBlock;
		  yourself
]

{ #category : 'icons' }
RMDColorTriangleTableColumn class >> yellowTriangleIcon [

	^ YellowTriangleIcon ifNil: [
		  | form canvas |
		  form := Form extent: 11 @ 11 depth: 32.
		  canvas := form getCanvas.
		  canvas fillColor: Color transparent.
		  canvas
			  drawPolygon: {
					  (1 @ 1).
					  (10 @ 5).
					  (1 @ 10) }
			  color: Color yellow
			  borderWidth: 1
			  borderColor: Color darkGray.
		  YellowTriangleIcon := form ]
]

{ #category : 'defaults' }
RMDColorTriangleTableColumn >> defaultEvaluation [

	^ [ :item |
	  item isCorrectSyntax
		  ifTrue: [
			  ((item
				    errorNodesInTypecheck: RMDType any
				    subject: self subject
				    object: self object
				    utilities: self utilities
				    in: self simulationModel typechecker
				    permitUnresolvedAttributeReference:
				    self permitsUnresolvedAttributeReference) isEmpty and: [
				   namecrashBlock isNil or: [ namecrashBlock cull: item ] ])
				  ifTrue: [ self greenTriangleIcon ]
				  ifFalse: [ self yellowTriangleIcon ] ]
		  ifFalse: [ self redTriangleIcon ] ]
]

{ #category : 'icons' }
RMDColorTriangleTableColumn >> greenTriangleIcon [

	^ self class greenTriangleIcon
]

{ #category : 'initialize' }
RMDColorTriangleTableColumn >> initialize [

	super initialize.
	self evaluated: self defaultEvaluation.
	self width: 14
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> namecrashBlock [

	^ namecrashBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> namecrashBlock: aBlock [

	namecrashBlock := aBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> object [

	^ objectBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> objectBlock [

	^ objectBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> objectBlock: aBlock [

	objectBlock := aBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> permitUnresolvedAttributeReference [

	permitsUnresolvedAttributeReference := true
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> permitsUnresolvedAttributeReference [

	^ permitsUnresolvedAttributeReference = true
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> permitsUnresolvedAttributeReference: aBoolean [

	permitsUnresolvedAttributeReference := aBoolean
]

{ #category : 'icons' }
RMDColorTriangleTableColumn >> redTriangleIcon [

	^ self class redTriangleIcon
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> simulationModel [

	^ simulationModelBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> simulationModelBlock [

	^ simulationModelBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> simulationModelBlock: aBlock [

	simulationModelBlock := aBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> subject [

	^ subjectBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> subjectBlock [

	^ subjectBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> subjectBlock: aBlock [

	subjectBlock := aBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> utilities [

	^ utilitiesBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> utilitiesBlock [

	^ utilitiesBlock
]

{ #category : 'accessing' }
RMDColorTriangleTableColumn >> utilitiesBlock: aBlock [

	utilitiesBlock := aBlock
]

{ #category : 'icons' }
RMDColorTriangleTableColumn >> yellowTriangleIcon [

	^ self class yellowTriangleIcon
]
