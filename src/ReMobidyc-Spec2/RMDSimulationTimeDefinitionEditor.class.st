Class {
	#name : #RMDSimulationTimeDefinitionEditor,
	#superclass : #RMDSyntaxNodeEditor,
	#instVars : [
		'durationField',
		'stepField',
		'durationUnitDropList',
		'stepUnitDropList'
	],
	#category : #'ReMobidyc-Spec2'
}

{ #category : #specs }
RMDSimulationTimeDefinitionEditor class >> defaultSpec [
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
RMDSimulationTimeDefinitionEditor >> durationField [
	^ durationField
]

{ #category : #accessing }
RMDSimulationTimeDefinitionEditor >> durationUnitDropList [
	^ durationUnitDropList
]

{ #category : #initialization }
RMDSimulationTimeDefinitionEditor >> initializeWidgets [
	durationField := self newNumberInput
		beFloat;
		acceptOnCR: true;
		whenNumberChangedDo: [ :val | 
			node
				ifNotNil: [ node
						duration:
							(RMDLiteralNode
								literal: val printString
								type: durationUnitDropList selectedItem) ] ];
		yourself.
	durationUnitDropList := self newDropList
		items:
			{RMDUnit year.
			RMDUnit month.
			RMDUnit week.
			RMDUnit day};
		selectIndex: 4;
		whenSelectedItemChangedDo: [ :newUnit | 
			node
				ifNotNil: [ node
						duration:
							(RMDLiteralNode
								literal: (newUnit fromSI: node duration numeric) printString
								type: newUnit).
					self updateDurationField ] ];
		yourself.
	stepField := self newNumberInput
		beFloat;
		yourself.
	stepUnitDropList := self newDropList
		items:
			{RMDUnit year.
			RMDUnit month.
			RMDUnit week.
			RMDUnit day};
		selectIndex: 4;
		yourself
]

{ #category : #accessing }
RMDSimulationTimeDefinitionEditor >> nodeChanged [
	self updateDurationField.
	self updateDurationUnit.
	self updateStepField.
	self updateStepUnit
]

{ #category : #accessing }
RMDSimulationTimeDefinitionEditor >> stepField [
	^ stepField
]

{ #category : #accessing }
RMDSimulationTimeDefinitionEditor >> stepUnitDropList [
	^ stepUnitDropList
]

{ #category : #updating }
RMDSimulationTimeDefinitionEditor >> updateDurationField [
	durationField
		number:
			(node
				ifNil: [ 0 ]
				ifNotNil: [ node duration type fromSI: node duration numeric ])
]

{ #category : #updating }
RMDSimulationTimeDefinitionEditor >> updateDurationUnit [
	durationUnitDropList selectItem: node duration type
]

{ #category : #updating }
RMDSimulationTimeDefinitionEditor >> updateStepField [
	stepField
		number:
			(node
				ifNil: [ 0 ]
				ifNotNil: [ node step type fromSI: node step numeric ])
]

{ #category : #updating }
RMDSimulationTimeDefinitionEditor >> updateStepUnit [
	stepUnitDropList selectItem: node step type
]
