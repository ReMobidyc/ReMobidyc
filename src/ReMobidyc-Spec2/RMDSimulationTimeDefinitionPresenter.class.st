Class {
	#name : #RMDSimulationTimeDefinitionPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'durationField',
		'stepField',
		'durationUnitDropList',
		'stepUnitDropList'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDSimulationTimeDefinitionPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: 'during ' expand: false;
				add: #durationField width: 80;
				add: #durationUnitDropList width: 80;
				add: ' step by ' expand: false;
				add: #stepField width: 60;
				add: #stepUnitDropList width: 80;
				yourself)
		height: self inputTextHeight
]

{ #category : #accessing }
RMDSimulationTimeDefinitionPresenter >> durationField [
	^ durationField
]

{ #category : #accessing }
RMDSimulationTimeDefinitionPresenter >> durationUnitDropList [
	^ durationUnitDropList
]

{ #category : #initialization }
RMDSimulationTimeDefinitionPresenter >> initializePresenters [
	super initializePresenters.
	durationField := self newNumberInput
		beFloat;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :val | 
			node
				ifNotNil: [ node
						duration:
							(RMDLiteralNode
								literal: val printString
								unit: durationUnitDropList selectedItem) ] ];
		yourself.
	durationUnitDropList := self newDropList
		items:
			{RMDUnit year.
			RMDUnit month.
			RMDUnit week.
			RMDUnit day.
			RMDUnit hour};
		selectIndex: 4;
		whenSelectedItemChangedDo: [ :newUnit | 
			node
				ifNotNil: [ node
						duration:
							(RMDLiteralNode
								literal: (newUnit fromSI: node duration numeric) printString
								unit: newUnit).
					self updateDurationField ] ];
		yourself.
	stepField := self newNumberInput
		beFloat;
		autoAccept: true;
		whenLastValidNumberChangedDo: [ :val | 
			node
				ifNotNil: [ node
						step:
							(RMDLiteralNode
								literal: val printString
								unit: stepUnitDropList selectedItem) ] ];
		yourself.
	stepUnitDropList := self newDropList
		items:
			{RMDUnit year.
			RMDUnit month.
			RMDUnit week.
			RMDUnit day.
			RMDUnit hour};
		selectIndex: 4;
		whenSelectedItemChangedDo: [ :newUnit | 
			node
				ifNotNil: [ node
						step:
							(RMDLiteralNode
								literal: (newUnit fromSI: node step numeric) printString
								unit: newUnit).
					self updateStepField ] ];
		yourself
]

{ #category : #accessing }
RMDSimulationTimeDefinitionPresenter >> nodeChanged [
	self updateDurationUnit.
	self updateDurationField.
	self updateStepUnit.
	self updateStepField
]

{ #category : #accessing }
RMDSimulationTimeDefinitionPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : #accessing }
RMDSimulationTimeDefinitionPresenter >> stepField [
	^ stepField
]

{ #category : #accessing }
RMDSimulationTimeDefinitionPresenter >> stepUnitDropList [
	^ stepUnitDropList
]

{ #category : #updating }
RMDSimulationTimeDefinitionPresenter >> updateDurationField [
	durationField
		number:
			(node
				ifNil: [ 0 ]
				ifNotNil: [ node duration unit fromSI: node duration numeric ])
]

{ #category : #updating }
RMDSimulationTimeDefinitionPresenter >> updateDurationUnit [
	node
		ifNotNil: [ durationUnitDropList selectItem: node duration unit ]
]

{ #category : #updating }
RMDSimulationTimeDefinitionPresenter >> updateStepField [
	stepField
		number:
			(node
				ifNil: [ 0 ]
				ifNotNil: [ node step unit fromSI: node step numeric ])
]

{ #category : #updating }
RMDSimulationTimeDefinitionPresenter >> updateStepUnit [
	node ifNotNil: [ stepUnitDropList selectItem: node step unit ]
]
