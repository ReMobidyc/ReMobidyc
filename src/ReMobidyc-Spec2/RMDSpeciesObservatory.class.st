Class {
	#name : #RMDSpeciesObservatory,
	#superclass : #RMDPresenter,
	#instVars : [
		'#interpreter => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #initialization }
RMDSpeciesObservatory >> initialize [
	super initialize.
	self property: #interpreter whenChangedDo: [ self updateObservation ]
]

{ #category : #accessing }
RMDSpeciesObservatory >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDSpeciesObservatory >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateObservation
		to: self
]

{ #category : #accessing }
RMDSpeciesObservatory >> interpreterDo: aBlock [
	interpreter ifNotNil: aBlock
]

{ #category : #private }
RMDSpeciesObservatory >> propertyValuesDo: aBlock [
	interpreter
		ifNotNil: [ self
				speciesDefinitionDo: [ :speciesDefinition | 
					^ aBlock
						cull:
							(RMDPropertyValues
								fromInterpreter: interpreter
								animat: speciesDefinition) ] ]
]

{ #category : #private }
RMDSpeciesObservatory >> speciesDefinitionDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #private }
RMDSpeciesObservatory >> updateObservation [
	^ self subclassResponsibility 
]
