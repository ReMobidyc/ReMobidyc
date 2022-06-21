Class {
	#name : #RMDTabularInspector,
	#superclass : #RMDAgentInspector,
	#instVars : [
		'table'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #layout }
RMDTabularInspector class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical add: #table
]

{ #category : #private }
RMDTabularInspector >> createTable [

	^ self newTable
		  beSingleSelection;
		  beResizable;
		  showColumnHeaders;
		  yourself
]

{ #category : #initialization }
RMDTabularInspector >> initializePresenters [
	super initializePresenters.
	table := self createTable.
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
	self attributeValuesDo: [ :attributeValues | 
		table
			columns: (Array streamContents: [ :stream | 
						 stream nextPut:
								 (SpStringTableColumn title: 'ID' evaluated: [ :index | 
										  index isInteger
											  ifTrue: [ (attributeValues ids at: index) printString ]
											  ifFalse: [ index ] ]).
						 attributeValues attributesDo: [ :attributeDef :values :stats | 
								 stream nextPut: (SpStringTableColumn
											  title: attributeDef printString
											  evaluated: [ :index | 
												  (index isInteger
													   ifTrue: [ values at: index ifAbsent: [ nil ] ]
													   ifFalse: [ stats at: index ifAbsent: [ nil ] ]) 
													  ifNotNil: [ :v | v printShowingDecimalPlaces: 2 ] ]) ] ]);
			items: #( min max mean sd ) , (1 to: attributeValues numberOfValues) ]
]
