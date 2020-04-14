Class {
	#name : #RMDAnimatRenderer,
	#superclass : #RMDRenderer,
	#instVars : [
		'species'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDAnimatRenderer class >> on: aString [
	^ self new
		species: aString;
		yourself
]

{ #category : #drawing }
RMDAnimatRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
	| animatDefinition |
	animatDefinition := species isString
		ifTrue: [ aRMDInterpreter
				animatDefinitionAt: species
				ifAbsent: [ ^ KeyNotFound signal: species ] ]
		ifFalse: [ species ].
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

{ #category : #accessing }
RMDAnimatRenderer >> species [
	^ species
]

{ #category : #accessing }
RMDAnimatRenderer >> species: aString [
	species := aString
]
