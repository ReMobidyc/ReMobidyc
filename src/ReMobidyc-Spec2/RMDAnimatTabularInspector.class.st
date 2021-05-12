Class {
	#name : #RMDAnimatTabularInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'#interpreter => SpObservableSlot',
		'#animat => SpObservableSlot',
		'#table'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDAnimatTabularInspector class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical add: #table
]

{ #category : #accessing }
RMDAnimatTabularInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatTabularInspector >> animat: aString [
	animat := aString
]

{ #category : #initialization }
RMDAnimatTabularInspector >> initialize [
	super initialize.
	self property: #interpreter whenChangedDo: [ self updateTable ].
	self property: #animat whenChangedDo: [ self updateTable ]
]

{ #category : #initialization }
RMDAnimatTabularInspector >> initializePresenters [
	super initializePresenters.
	table := self newTable
		beSingleSelection;
		beResizable;
		showColumnHeaders;
		yourself.
	self updateTable
]

{ #category : #accessing }
RMDAnimatTabularInspector >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDAnimatTabularInspector >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateTable
		to: self
]

{ #category : #accessing }
RMDAnimatTabularInspector >> table [
	^ table
]

{ #category : #private }
RMDAnimatTabularInspector >> updateTable [
	interpreter ifNil: [ ^ self ].
	animat ifNil: [ ^ self ].
	table ifNil: [ ^ self ].
	interpreter
		animatDefinitionAt: animat
		ifPresent: [ :animatDef | 
			table
				columns:
					(Array
						streamContents: [ :stream | 
							stream
								nextPut: (SpStringTableColumn title: 'ID' evaluated: [ :id | id printString ]).
							animatDef
								propertyDeclarationsDo: [ :propertyDef | 
									stream
										nextPut:
											(SpStringTableColumn
												title: propertyDef printString
												evaluated: [ :id | 
													interpreter
														withObserverContextWithSubject: id
														species: animatDef
														do: [ (propertyDef unit
																fromSI:
																	(interpreter
																		readVariable: propertyDef identifier
																		agent: nil
																		ifAbsent: [ nil ])) printShowingDecimalPlaces: 2 ] ]) ] ]);
				items:
					(Array
						streamContents:
							[ :stream | interpreter individualsOf: animatDef do: [ :id | stream nextPut: id ] ]) ]
]
