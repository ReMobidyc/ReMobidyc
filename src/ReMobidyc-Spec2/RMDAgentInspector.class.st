Class {
	#name : #RMDAgentInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'#interpreter => ObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #private }
RMDAgentInspector >> agentDefinitionDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #private }
RMDAgentInspector >> attributeValuesDo: aBlock [
	interpreter
		ifNotNil: [ self
				agentDefinitionDo: [ :agentDefinition | 
					^ aBlock
						cull:
							(RMDAttributeValues
								fromInterpreter: interpreter
								animat: agentDefinition) ] ]
]

{ #category : #accessing }
RMDAgentInspector >> collapsedIcon [
	^ Smalltalk ui theme 	treeUnexpandedForm
]

{ #category : #accessing }
RMDAgentInspector >> expandedIcon [
	^ Smalltalk ui theme 	treeExpandedForm
]

{ #category : #initialization }
RMDAgentInspector >> initialize [
	super initialize.
	self property: #interpreter whenChangedDo: [ self updateObservation ]
]

{ #category : #accessing }
RMDAgentInspector >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDAgentInspector >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #timeChanged:
		to: self
]

{ #category : #accessing }
RMDAgentInspector >> interpreterDo: aBlock [
	interpreter ifNotNil: aBlock
]

{ #category : #accessing }
RMDAgentInspector >> spawnIcon [

	^ Smalltalk ui iconNamed: #expandBox
]

{ #category : #private }
RMDAgentInspector >> timeChanged: aRMDTimeChanged [
	self updateObservation
]

{ #category : #private }
RMDAgentInspector >> updateObservation [
	^ self subclassResponsibility 
]
