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
	self
		speciesDefinitionDo: [ :def | 
			table columns
				ifEmpty: [ table
						columns:
							(Array
								streamContents: [ :stream | 
									stream
										nextPut: (SpStringTableColumn title: 'ID' evaluated: [ :id | id printString ]).
									def
										propertyDeclarationsDo: [ :propertyDef | 
											stream
												nextPut:
													(SpStringTableColumn
														title: propertyDef printString
														evaluated: [ :id | 
															interpreter
																withObserverContextWithSubject: id
																species: def
																do: [ (propertyDef unit
																		fromSI:
																			(interpreter
																				readVariable: propertyDef identifier
																				agent: nil
																				ifAbsent: [ nil ])) printShowingDecimalPlaces: 2 ] ]) ] ]) ].
			table
				items:
					(Array
						streamContents:
							[ :stream | interpreter individualsOf: def do: [ :id | stream nextPut: id ] ]) ]
]
