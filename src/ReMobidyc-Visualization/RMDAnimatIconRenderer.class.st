Class {
	#name : #RMDAnimatIconRenderer,
	#superclass : #RMDAnimatRenderer,
	#instVars : [
		'iconName'
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

{ #category : #comparing }
RMDAnimatIconRenderer >> = anObject [

	^ super = anObject and: [ iconName = anObject iconName ]
]

{ #category : #drawing }
RMDAnimatIconRenderer >> drawIndividual: anInteger with: aRMDInterpreter at: aPoint on: aCanvas [

	| form |
	form := aRMDInterpreter simulationModel
		        iconAt: iconName
		        ifAbsent: [ ^ self ].
	aCanvas paintImage: form at: aPoint - (form extent // 2)
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

{ #category : #accessing }
RMDAnimatIconRenderer >> name [

	^ 'icon renderer'
]

{ #category : #printing }
RMDAnimatIconRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> "';
		nextPutAll: (iconName asString copyReplaceAll: '"' with: '\"');
		nextPutAll: '" icon.'.
	aStream cr
]
