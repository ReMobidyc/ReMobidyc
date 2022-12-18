Class {
	#name : #RMDAnimatIconRenderer,
	#superclass : #RMDAnimatRenderer,
	#instVars : [
		'iconName',
		'scale'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDAnimatIconRenderer class >> on: aString iconName: anotherString [

	<script:
	'(RMDAnimatIconRenderer on: ''Goat'' iconName: ''goat.png'') inspect'>
	^ (self on: aString)
		  iconName: anotherString;
		  yourself
]

{ #category : #'instance creation' }
RMDAnimatIconRenderer class >> on: aString iconName: anotherString scale: aNumber [

	<script:
	'(RMDAnimatIconRenderer on: ''Goat'' iconName: ''goat.png'') inspect'>
	^ (self on: aString)
		  iconName: anotherString;
		  scale: aNumber;
		  yourself
]

{ #category : #comparing }
RMDAnimatIconRenderer >> = anObject [

	^ super = anObject and: [ iconName = anObject iconName ]
]

{ #category : #defaults }
RMDAnimatIconRenderer >> defaultScale [
	^ 1.0
]

{ #category : #drawing }
RMDAnimatIconRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [

	| form animatDefinition |
	form := (aRMDInterpreter simulationModel
		         iconAt: iconName
		         ifAbsent: [ ^ self ]) magnifyBy: scale.
	animatDefinition := animat isString
		                    ifTrue: [ 
			                    aRMDInterpreter
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
				aCanvas paintImage: form at: (self
						 pointFromX: x
						 y: y
						 interpreter: aRMDInterpreter
						 scale: aNumber) - (form extent // 2) ] ]
]

{ #category : #comparing }
RMDAnimatIconRenderer >> hash [

	^ super hash bitXor: iconName hash
]

{ #category : #accessing }
RMDAnimatIconRenderer >> iconName [

	^ iconName
]

{ #category : #accessing }
RMDAnimatIconRenderer >> iconName: aString [

	iconName := aString
]

{ #category : #enumerating }
RMDAnimatIconRenderer >> iconNamesDo: aBlock [

	iconName ifNotNil: [ aBlock value: iconName ]
]

{ #category : #initialization }
RMDAnimatIconRenderer >> initialize [ 
	super initialize.
	scale := self defaultScale
]

{ #category : #accessing }
RMDAnimatIconRenderer >> name [

	^ 'icon renderer'
]

{ #category : #printing }
RMDAnimatIconRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> "';
		nextPutAll: (iconName asString copyReplaceAll: '"' with: '\" ');
		nextPutAll: '" '.
	scale printOn: aStream.
	aStream nextPutAll: 'x icon.'.
	aStream cr
]

{ #category : #accessing }
RMDAnimatIconRenderer >> scale [
	^ scale
]

{ #category : #accessing }
RMDAnimatIconRenderer >> scale: aNumber [
	scale := aNumber asFloat
]
