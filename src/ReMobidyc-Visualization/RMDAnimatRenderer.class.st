Class {
	#name : #RMDAnimatRenderer,
	#superclass : #RMDRenderer,
	#instVars : [
		'animat'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDAnimatRenderer class >> on: aString [
	^ self new
		animat: aString;
		yourself
]

{ #category : #accessing }
RMDAnimatRenderer >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatRenderer >> animat: aString [
	animat := aString
]

{ #category : #drawing }
RMDAnimatRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
	| animatDefinition |
	animatDefinition := animat isString
		ifTrue: [ aRMDInterpreter
				animatDefinitionAt: animat
				ifAbsent: [ ^ KeyNotFound signal: animat ] ]
		ifFalse: [ animat ].
	aRMDInterpreter
		individualsOf: animatDefinition
		do: [ :individual | 
			| x y |
			aRMDInterpreter
				setObserverContextWithSubject: individual
				species: animatDefinition.
			x := aRMDInterpreter
				readVariable: 'x'
				agent: nil
				ifAbsent: [ ^ KeyNotFound signal: 'x' ].
			y := aRMDInterpreter
				readVariable: 'y'
				agent: nil
				ifAbsent: [ ^ KeyNotFound signal: 'x' ].
			self
				drawIndividual: individual
				with: aRMDInterpreter
				at:
					(self
						pointFromX: x
						y: y
						interpreter: aRMDInterpreter
						scale: aNumber)
				on: aCanvas ]
]

{ #category : #drawing }
RMDAnimatRenderer >> drawIndividual: anInteger with: aRMDInterpreter at: aPoint on: aCanvas [
	^ self subclassResponsibility
]
