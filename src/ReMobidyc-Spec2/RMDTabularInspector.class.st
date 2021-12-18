Class {
	#name : #RMDTabularInspector,
	#superclass : #RMDSpeciesObservatory,
	#instVars : [
		'table'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDTabularInspector class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical add: #table
]

{ #category : #initialization }
RMDTabularInspector >> initializePresenters [
	super initializePresenters.
	table := self newTable
		beSingleSelection;
		beResizable;
		showColumnHeaders;
		yourself.
	self updateTable
]

{ #category : #accessing }
RMDTabularInspector >> table [
	^ table
]

{ #category : #private }
RMDTabularInspector >> updateObservation [
	self updateTable
]

{ #category : #private }
RMDTabularInspector >> updateTable [

	table ifNil: [ ^ self ].
	self propertyValuesDo: [ :propertyValues | 
		table
			columns: (Array streamContents: [ :stream | 
						 stream nextPut:
								 (SpStringTableColumn title: 'ID' evaluated: [ :index | 
										  index isInteger
											  ifTrue: [ (propertyValues ids at: index) printString ]
											  ifFalse: [ index ] ]).
						 propertyValues propertiesDo: [ :propertyDef :values :stats | 
								 stream nextPut: (SpStringTableColumn
											  title: propertyDef printString
											  evaluated: [ :index | 
												  (index isInteger
													   ifTrue: [ values at: index ifAbsent: [ nil ] ]
													   ifFalse: [ stats at: index ifAbsent: [ nil ] ]) 
													  ifNotNil: [ :v | v printShowingDecimalPlaces: 2 ] ]) ] ]);
			items: #( min max mean sd ) , (1 to: propertyValues numberOfValues) ]
]
