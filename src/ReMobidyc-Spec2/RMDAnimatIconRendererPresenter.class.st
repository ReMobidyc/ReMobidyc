Class {
	#name : #RMDAnimatIconRendererPresenter,
	#superclass : #RMDAnimatRendererPresenter,
	#instVars : [
		'iconNameButton',
		'scaleField',
		'iconImage',
		'simulationModel'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAnimatIconRendererPresenter class >> defaultLayout [

	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: #iconNameButton expand: false;
				   add: #scaleField width: 100;
				   add: 'x ' expand: false;
				   add: #iconImage width: 40;
				   yourself)
		  height: self inputTextHeight
]

{ #category : #operations }
RMDAnimatIconRendererPresenter >> addNewIconToSimulationModelDo: aBlock [

	| icons |
	simulationModel ifNil: [ ^ self ].
	icons := simulationModel iconNames asSet.
	RMDRepositoryIconsBrowser openToLoadDo: [ :form :browser | 
		| iconName |
		iconName := ''.
		[ iconName = '' ] whileTrue: [ 
			iconName := (UIManager default
				             request: 'Icon name'
				             initialAnswer: browser file basename) ifNotNil: [ 
				            :name | 
				            (icons includes: name)
					            ifTrue: [ '' ]
					            ifFalse: [ name ] ] ].
		(iconName endsWith: '.png') ifFalse: [ 
			iconName := iconName , '.png' ].
		simulationModel iconAt: iconName put: form.
		aBlock value: iconName ]
]

{ #category : #operations }
RMDAnimatIconRendererPresenter >> changeIconName [

	simulationModel ifNil: [ ^ self ].
	(self newMenu
		 addGroup: [ :group | 
			 group addItem: [ :item | 
					 item
						 icon: self addIcon;
						 action: [ 
							 self addNewIconToSimulationModelDo: [ :newIconName | 
									 self iconName: newIconName ] ] ] ];
		 addGroup: [ :group | 
			 simulationModel iconNames do: [ :newIconName | 
				 group addItem: [ :item | 
					 item
						 name: newIconName;
						 action: [ self iconName: newIconName ] ] ] ])
		openWithSpecAtPointer
]

{ #category : #accessing }
RMDAnimatIconRendererPresenter >> iconName: aString [

	renderer iconName: aString.
	self
		updateIconNameButton;
		updateScaleField
]

{ #category : #initialization }
RMDAnimatIconRendererPresenter >> initializePresenters [

	super initializePresenters.
	iconNameButton := self newLabel.
	scaleField := self newNumberInput
		              beFloat;
		              minimum: 0.0;
		              maximum: 4.0;
		              climbRate: 0.1;
		              number: 1.0;
		              whenNumberChangedDo: [ :number | 
			              renderer ifNotNil: [ 
					              renderer scale: number.
					              self updateIconNameButton ] ];
		              yourself.
	iconImage := self newButton
		             action: [ self changeIconName ];
		             yourself
]

{ #category : #accessing }
RMDAnimatIconRendererPresenter >> preferredHeight [
	^ self class buttonHeight
]

{ #category : #accessing }
RMDAnimatIconRendererPresenter >> rendererChanged [

	super rendererChanged.
	self
		updateIconNameButton;
		updateScaleField
]

{ #category : #accessing }
RMDAnimatIconRendererPresenter >> simulationModel [

	^ simulationModel
]

{ #category : #accessing }
RMDAnimatIconRendererPresenter >> simulationModel: aRMDSimulationModel [

	simulationModel := aRMDSimulationModel.
	self
		updateIconNameButton;
		updateScaleField
]

{ #category : #updating }
RMDAnimatIconRendererPresenter >> updateIconNameButton [

	renderer ifNotNil: [ 
		iconNameButton label: renderer iconName.
		iconImage icon: (simulationModel ifNotNil: [ 
				 (simulationModel iconAt: renderer iconName ifAbsent: [ nil ]) 
					 magnifyBy: renderer scale ]) ]
]

{ #category : #updating }
RMDAnimatIconRendererPresenter >> updateScaleField [

	renderer ifNotNil: [ scaleField number: renderer scale ]
]
