Class {
	#name : 'RMDActionContext',
	#superclass : 'RMDExecutionContextWithRandomGenerator',
	#instVars : [
		'action',
		'object',
		'objectDefinition',
		'newDefinition',
		'newIndividuals',
		'locationBlock',
		'patchDefinition',
		'location',
		'space'
	],
	#category : 'ReMobidyc-Interpreter-Contexts',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Contexts'
}

{ #category : 'accessing' }
RMDActionContext >> action [
	^ action
]

{ #category : 'accessing' }
RMDActionContext >> action: aRMDActionDefinitionNode [

	action := aRMDActionDefinitionNode.
	self loadUtilityDefinitions: action utilityDefinitions
]

{ #category : 'memory access' }
RMDActionContext >> attributeDictFor: aString [

	aString = 'here' ifTrue: [ 
		^ self createPatchAttributeDict: self location ].
	aString = 'east' ifTrue: [ 
		space
			eastOf: self location
			do: [ :east | ^ self createPatchAttributeDict: east ] ].
	aString = 'west' ifTrue: [ 
		space
			westOf: self location
			do: [ :west | ^ self createPatchAttributeDict: west ].
		^ Dictionary new ].
	aString = 'south' ifTrue: [ 
		space
			southOf: self location
			do: [ :south | ^ self createPatchAttributeDict: south ] ].
	aString = 'north' ifTrue: [ 
		space
			northOf: self location
			do: [ :north | ^ self createPatchAttributeDict: north ] ].
	^ Dictionary new
]

{ #category : 'memory access' }
RMDActionContext >> createPatchAttributeDict: anInteger [

	^ patchDefinition attributeOffsets copy associationsDo: [ :assoc | 
		  assoc value: anInteger + assoc value ]
]

{ #category : 'testing' }
RMDActionContext >> hasObject [

	^ object notNil
]

{ #category : 'accessing' }
RMDActionContext >> location [

	^ location ifNil: [ location := locationBlock value ]
]

{ #category : 'accessing' }
RMDActionContext >> location: anIntegerOrBlock definition: aRMDPatchDefinition [

	patchDefinition := aRMDPatchDefinition.
	locationBlock := anIntegerOrBlock
]

{ #category : 'accessing' }
RMDActionContext >> locationDefinition [

	^ patchDefinition
]

{ #category : 'accessing' }
RMDActionContext >> newDefinition [

	^ newDefinition
]

{ #category : 'accessing' }
RMDActionContext >> newIndividuals: anArrayOfInteger definition: aRMDAnimatDefinition [

	newIndividuals := anArrayOfInteger.
	newDefinition := aRMDAnimatDefinition
]

{ #category : 'enumerating' }
RMDActionContext >> newIndividualsDo: aBlock [

	newIndividuals ifNotNil: [ newIndividuals do: aBlock ]
]

{ #category : 'accessing' }
RMDActionContext >> object [
	^ object
]

{ #category : 'accessing' }
RMDActionContext >> object: anInteger definition: aRMDAnimatDefinition [

	object := anInteger.
	objectDefinition := aRMDAnimatDefinition
]

{ #category : 'accessing' }
RMDActionContext >> objectDefinition [
	^ objectDefinition
]

{ #category : 'printing' }
RMDActionContext >> printOn: aStream [

	subjectDefinition
		ifNotNil: [ aStream nextPutAll: subjectDefinition name ]
		ifNil: [ aStream nextPut: $- ].
	aStream nextPut: $(.
	subject
		ifNotNil: [ subject printOn: aStream ]
		ifNil: [ aStream nextPut: $- ].
	aStream
		nextPut: $);
		space.
	action
		ifNotNil: [ aStream nextPutAll: action identifier ]
		ifNil: [ aStream nextPut: $- ].
	aStream space.
	objectDefinition ifNotNil: [
		aStream nextPutAll: objectDefinition identifier ].
	object ifNotNil: [
		aStream nextPut: $(.
		object printOn: aStream.
		aStream nextPut: $) ]
]

{ #category : 'accessing' }
RMDActionContext >> space [
	^ space
]

{ #category : 'accessing' }
RMDActionContext >> space: aRMDMemory [

	space := aRMDMemory
]
