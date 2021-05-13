Class {
	#name : #RMDTabularInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'#table',
		'#interpreter => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDTabularInspector class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical add: #table
]

{ #category : #initialization }
RMDTabularInspector >> initialize [
	super initialize.
	self property: #interpreter whenChangedDo: [ self updateTable ]
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
RMDTabularInspector >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDTabularInspector >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateTable
		to: self
]

{ #category : #private }
RMDTabularInspector >> speciesDefinitionDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDTabularInspector >> table [
	^ table
]

{ #category : #private }
RMDTabularInspector >> updateTable [
	table ifNil: [ ^ self ].
	self
		speciesDefinitionDo: [ :def | 
			table
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
																		ifAbsent: [ nil ])) printShowingDecimalPlaces: 2 ] ]) ] ]);
				items:
					(Array
						streamContents:
							[ :stream | interpreter individualsOf: def do: [ :id | stream nextPut: id ] ]) ]
]
