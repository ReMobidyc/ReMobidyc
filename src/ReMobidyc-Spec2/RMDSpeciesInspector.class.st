Class {
	#name : #RMDSpeciesInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'#interpreter => ObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #private }
RMDSpeciesInspector >> attributeValuesDo: aBlock [
	interpreter
		ifNotNil: [ self
				speciesDefinitionDo: [ :speciesDefinition | 
					^ aBlock
						cull:
							(RMDAttributeValues
								fromInterpreter: interpreter
								animat: speciesDefinition) ] ]
]

{ #category : #accessing }
RMDSpeciesInspector >> collapsedIcon [
	^ Smalltalk ui theme 	treeUnexpandedForm
]

{ #category : #accessing }
RMDSpeciesInspector >> expandedIcon [
	^ Smalltalk ui theme 	treeExpandedForm
]

{ #category : #initialization }
RMDSpeciesInspector >> initialize [
	super initialize.
	self property: #interpreter whenChangedDo: [ self updateObservation ]
]

{ #category : #accessing }
RMDSpeciesInspector >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDSpeciesInspector >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateObservation
		to: self
]

{ #category : #accessing }
RMDSpeciesInspector >> interpreterDo: aBlock [
	interpreter ifNotNil: aBlock
]

{ #category : #accessing }
RMDSpeciesInspector >> spawnIcon [

	^ Smalltalk ui iconNamed: #expandBox
]

{ #category : #private }
RMDSpeciesInspector >> speciesDefinitionDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #private }
RMDSpeciesInspector >> updateObservation [
	^ self subclassResponsibility 
]
