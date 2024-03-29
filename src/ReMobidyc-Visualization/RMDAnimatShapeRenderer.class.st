Class {
	#name : #RMDAnimatShapeRenderer,
	#superclass : #RMDAnimatRenderer,
	#instVars : [
		'shapeSize'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #testing }
RMDAnimatShapeRenderer class >> isAbstract [

	^ self == RMDAnimatShapeRenderer
]

{ #category : #'instance creation' }
RMDAnimatShapeRenderer class >> on: aString shapeSize: anInteger color: aColor [

	^ (self on: aString)
		  shapeSize: anInteger;
		  color: aColor;
		  yourself
]

{ #category : #comparing }
RMDAnimatShapeRenderer >> = anObject [

	^ super = anObject and: [ shapeSize = anObject shapeSize ]
]

{ #category : #defaults }
RMDAnimatShapeRenderer >> defaultShapeSize [

	^ 3
]

{ #category : #drawing }
RMDAnimatShapeRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [

	| animatDefinition |
	animatDefinition := animat isString
		                    ifTrue: [ 
			                    aRMDInterpreter simulationModel
				                    animatDefinitionAt: animat
				                    ifAbsent: [ 
				                    ^ RMDUndefinedAnimatError signal: animat ] ]
		                    ifFalse: [ animat ].
	aRMDInterpreter individualsOf: animatDefinition do: [ :individual | 
		aRMDInterpreter
			withObserverContextWithSubject: individual
			definition: animatDefinition
			do: [ 
				| x y |
				x := aRMDInterpreter my: 'x'.
				y := aRMDInterpreter my: 'y'.
				self
					drawIndividual: individual
					with: aRMDInterpreter
					at: (self
							 pointFromX: x
							 y: y
							 interpreter: aRMDInterpreter
							 scale: aNumber)
					on: aCanvas ] ]
]

{ #category : #drawing }
RMDAnimatShapeRenderer >> drawIndividual: anInteger with: aRMDInterpreter at: aPoint on: aCanvas [
	^ self subclassResponsibility
]

{ #category : #comparing }
RMDAnimatShapeRenderer >> hash [

	^ super hash bitXor: shapeSize hash
]

{ #category : #initialization }
RMDAnimatShapeRenderer >> initialize [

	super initialize.
	shapeSize := self defaultShapeSize
]

{ #category : #accessing }
RMDAnimatShapeRenderer >> shapeSize [

	^ shapeSize
]

{ #category : #accessing }
RMDAnimatShapeRenderer >> shapeSize: anInteger [

	shapeSize := anInteger asInteger
]
