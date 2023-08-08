Class {
	#name : #RMDCSVImporter,
	#superclass : #RMDPresenter,
	#instVars : [
		'fileReference',
		'dataFrame',
		'sourceTable',
		'addConnectorButton',
		'removeConnectorButton',
		'editConnectorButton',
		'moveUpConnectorButton',
		'moveDownConnectorButton',
		'useCalendarDateButton',
		'yearDropList',
		'baseYearField',
		'monthDropList',
		'monthField',
		'dayDropList',
		'dayField',
		'hourDropList',
		'hourField',
		'minuteDropList',
		'minuteField',
		'secondDropList',
		'secondField',
		'timeUnitDropList',
		'timeDropList',
		'table',
		'tableConnector',
		'connectorList',
		'interpolateMissingValues',
		'useElapsedTimeButton'
	],
	#category : #'ReMobidyc-Spec2-DataSource'
}

{ #category : #layout }
RMDCSVImporter class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.4;
		  add: #sourceTable;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 0.4 / 0.6;
				   add: (SpGridLayout new
						    beColumnNotHomogeneous;
						    beRowNotHomogeneous;
						    column: 1 expand: false;
						    column: 3 expand: true;
						    column: 4 expand: true;
						    row: 1 expand: false;
						    row: 2 expand: false;
						    row: 3 expand: false;
						    row: 4 expand: false;
						    row: 5 expand: false;
						    row: 6 expand: false;
						    row: 7 expand: false;
						    row: 8 expand: false;
						    row: 9 expand: false;
						    row: 10 expand: false;
						    row: 11 expand: false;
						    row: 12 expand: false;
						    add: (SpBoxLayout newHorizontal
								     vAlignEnd;
								     add: '  unit of time  ' expand: false;
								     add: (SpBoxLayout newVertical
										      add: #timeUnitDropList
										      height: self buttonHeight);
								     yourself)
						    at: 1 @ 1 span: 4 @ 1;
						    add: #useElapsedTimeButton at: 1 @ 2 span: 4 @ 1;
						    add: '    ' asPresenter at: 1 @ 3;
						    add: 'Elapsed time' at: 2 @ 3;
						    add: #timeDropList at: 3 @ 3;
						    add: #useCalendarDateButton at: 1 @ 4 span: 4 @ 1;
						    add: 'year' at: 2 @ 5;
						    add: (SpBoxLayout newHorizontal
								     vAlignEnd;
								     add:
									     (SpBoxLayout newVertical
										      add: #yearDropList
										      height: self buttonHeight);
								     add: ' + ' expand: false)
						    at: 3 @ 5;
						    add: #baseYearField at: 4 @ 5;
						    add: 'month' at: 2 @ 6;
						    add:
						    (SpBoxLayout newVertical
							     add: #monthDropList
							     height: self buttonHeight)
						    at: 3 @ 6;
						    add: #monthField at: 4 @ 6;
						    add: 'day' at: 2 @ 7;
						    add:
						    (SpBoxLayout newVertical
							     add: #dayDropList
							     height: self buttonHeight)
						    at: 3 @ 7;
						    add: #dayField at: 4 @ 7;
						    add: 'hour' at: 2 @ 8;
						    add:
						    (SpBoxLayout newVertical
							     add: #hourDropList
							     height: self buttonHeight)
						    at: 3 @ 8;
						    add: #hourField at: 4 @ 8;
						    add: 'minute' at: 2 @ 9;
						    add: (SpBoxLayout newVertical
								     add: #minuteDropList
								     height: self buttonHeight)
						    at: 3 @ 9;
						    add: #minuteField at: 4 @ 9;
						    add: 'second' at: 2 @ 10;
						    add: (SpBoxLayout newVertical
								     add: #secondDropList
								     height: self buttonHeight)
						    at: 3 @ 10;
						    add: #secondField at: 4 @ 10;
						    add:
						    (SpBoxLayout newVertical add: #connectorList height: 100)
						    at: 1 @ 11
						    span: 4 @ 1;
						    add: (SpBoxLayout newHorizontal
								     add: #addConnectorButton width: self buttonHeight;
								     add: #removeConnectorButton width: self buttonHeight;
								     add: #moveUpConnectorButton width: self buttonHeight;
								     add: #moveDownConnectorButton width: self buttonHeight;
								     add: #editConnectorButton width: self buttonHeight;
								     yourself)
						    at: 1 @ 12 span: 4 @ 1;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: #table;
						    add: #interpolateMissingValues expand: false;
						    yourself);
				   yourself);
		  yourself
]

{ #category : #'instance creation' }
RMDCSVImporter class >> on: aFileReference [

	^ self new
		  fileReference: aFileReference;
		  yourself
]

{ #category : #operations }
RMDCSVImporter >> addConnector [

	RMDColumnConnectorPresenter
		openDialogWithColumns: dataFrame columnNames
		onAccept: [ :connector |
			connector ifNotNil: [
				(tableConnector addAttributeConnector: connector ifPresent: [
					 UIManager default
						 alert: 'Connector for the attribute ' , connector attribute
							 , ' is already defined.'
						 title: 'Duplicate attribute error'.
					 nil ]) ifNotNil: [
					connectorList items: tableConnector attributeConnectors.
					self updateTable ] ] ]
]

{ #category : #accessing }
RMDCSVImporter >> disableColor [

	^ Color gray: 0.8
]

{ #category : #operations }
RMDCSVImporter >> editConnector [

	connectorList selectedItem ifNotNil: [ :connector |
		RMDColumnConnectorPresenter
			openDialogWithColumns: dataFrame columnNames
			connector: connector
			onAccept: [ :newConnector |
				newConnector ifNotNil: [
					(tableConnector attributeConnectors anySatisfy: [ :c |
						 c ~= connector and: [ c attribute = newConnector attribute ] ])
						ifFalse: [
							connector
								columnName: newConnector columnName;
								attribute: newConnector attribute;
								unit: newConnector unit;
								interpolation: newConnector interpolation.
							connectorList refresh.
							self updateTable ] ] ] ]
]

{ #category : #accessing }
RMDCSVImporter >> errorColor [

	^ self theme backgroundColor mixed: 0.9 with: Color red
]

{ #category : #accessing }
RMDCSVImporter >> fileReference [

	^ fileReference
]

{ #category : #accessing }
RMDCSVImporter >> fileReference: aFileReference [

	fileReference = aFileReference ifTrue: [ ^ self ].
	fileReference := aFileReference.
	self updateDataFrame
]

{ #category : #initialization }
RMDCSVImporter >> initializePresenters [

	super initializePresenters.
	sourceTable := self newTable.
	connectorList := self newTable
		                 beResizable;
		                 addColumn:
			                 (SpStringTableColumn
				                  title: 'column'
				                  evaluated: #columnName) beExpandable;
		                 addColumn:
			                 (SpStringTableColumn
				                  title: 'attribute'
				                  evaluated: #attribute) beExpandable;
		                 addColumn:
			                 (SpStringTableColumn
				                  title: 'unit'
				                  evaluated: #unit) beNotExpandable;
		                 addColumn:
			                 (SpStringTableColumn
				                  title: 'interpolation'
				                  evaluated: #interpolation) beExpandable;
		                 whenSelectedItemChangedDo: [ self updateButtons ];
		                 yourself.
	addConnectorButton := self newButton
		                      icon: self addIcon;
		                      help: 'Add column import';
		                      action: [ self addConnector ];
		                      yourself.
	removeConnectorButton := self newButton
		                         icon: self removeIcon;
		                         help: 'Remove column import';
		                         action: [ self removeConnector ];
		                         yourself.
	editConnectorButton := self newButton
		                       icon: self editIcon;
		                       help: 'Edit column import';
		                       action: [ self editConnector ];
		                       yourself.
	moveUpConnectorButton := self newButton
		                         icon: self upIcon;
		                         help: 'Move up column import';
		                         action: [ self moveUpConnector ];
		                         yourself.
	moveDownConnectorButton := self newButton
		                           icon: self downIcon;
		                           help: 'Move down column import';
		                           action: [ self moveDownConnector ];
		                           yourself.
	yearDropList := self newDropList
		                display: [ :string | string ifNil: [ '-' ] ];
		                whenSelectedItemChangedDo: [
			                self updateYearConnector ];
		                yourself.
	baseYearField := self newNumberInput
		                 beInteger;
		                 placeholder: 'YYYY';
		                 whenNumberChangedDo: [ self updateYearConnector ];
		                 yourself.
	monthDropList := self newDropList
		                 display: [ :string | string ifNil: [ '-' ] ];
		                 whenSelectedItemChangedDo: [
			                 self updateMonthConnector ];
		                 yourself.
	monthField := self newNumberInput
		              beInteger;
		              placeholder: 'MM';
		              whenNumberChangedDo: [ self updateMonthConnector ];
		              yourself.
	dayDropList := self newDropList
		               display: [ :string | string ifNil: [ '-' ] ];
		               whenSelectedItemChangedDo: [ self updateDayConnector ];
		               yourself.
	dayField := self newNumberInput
		            beInteger;
		            placeholder: 'DD';
		            whenNumberChangedDo: [ self updateDayConnector ];
		            yourself.
	hourDropList := self newDropList
		                display: [ :string | string ifNil: [ '-' ] ];
		                whenSelectedItemChangedDo: [
			                self updateHourConnector ];
		                yourself.
	hourField := self newNumberInput
		             beInteger;
		             placeholder: 'hh';
		             whenNumberChangedDo: [ self updateHourConnector ];
		             yourself.
	minuteDropList := self newDropList
		                  display: [ :string | string ifNil: [ '-' ] ];
		                  whenSelectedItemChangedDo: [
			                  self updateMinuteConnector ];
		                  yourself.
	minuteField := self newNumberInput
		               beInteger;
		               placeholder: 'mm';
		               whenNumberChangedDo: [ self updateMinuteConnector ];
		               yourself.
	secondDropList := self newDropList
		                  display: [ :string | string ifNil: [ '-' ] ];
		                  whenSelectedItemChangedDo: [
			                  self updateSecondConnector ];
		                  yourself.
	secondField := self newNumberInput
		               beInteger;
		               placeholder: 'ss';
		               whenNumberChangedDo: [ self updateSecondConnector ];
		               yourself.
	timeUnitDropList := self newDropList
		                    items: {
				                    RMDUnit year.
				                    RMDUnit month.
				                    RMDUnit day.
				                    RMDUnit hour.
				                    RMDUnit minute.
				                    RMDUnit second };
		                    selectIndex: 3;
		                    whenSelectedItemChangedDo: [ self updateTable ];
		                    yourself.
	timeDropList := self newDropList
		                display: [ :string | string ifNil: [ '-' ] ];
		                whenSelectedItemChangedDo: [
			                self updateTimeConnector ];
		                yourself.
	useCalendarDateButton := self newRadioButton
		                         label: 'Use calendar dates';
		                         state: true;
		                         whenActivatedDo: [ self useCalendarDates ];
		                         yourself.
	useElapsedTimeButton := self newRadioButton
		                        label: 'Use elapsed time';
		                        state: false;
		                        whenActivatedDo: [ self useElapsedTime ];
		                        associatedRadioButtons:
			                        { useCalendarDateButton };
		                        yourself.
	table := self newTable
		         whenBuiltDo: [ table color: table color ];
		         yourself.
	interpolateMissingValues := self newCheckBox
		                            label: 'interpolate missing values';
		                            state: false;
		                            whenChangedDo: [ self updateTable ];
		                            yourself.
	self whenBuiltDo: [
		(self window notNil and: [ self window isDialog ]) ifTrue: [
			self window buttons first disable ] ]
]

{ #category : #initialization }
RMDCSVImporter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 950 @ 560
]

{ #category : #operations }
RMDCSVImporter >> moveDownConnector [

	| index connector1 connector2 |
	index := connectorList selection selectedIndex.
	index = 0 ifTrue: [ ^ self ].
	index = connectorList items size ifTrue: [ ^ self ].
	connector1 := tableConnector attributeConnectors at: index.
	connector2 := tableConnector attributeConnectors at: index + 1.
	tableConnector attributeConnectors at: index + 1 put: connector1.
	tableConnector attributeConnectors at: index put: connector2.
	connectorList
		items: tableConnector attributeConnectors;
		selectIndex: index + 1
]

{ #category : #operations }
RMDCSVImporter >> moveUpConnector [

	| index connector1 connector2 |
	index := connectorList selection selectedIndex.
	index <= 1 ifTrue: [ ^ self ].
	connector1 := tableConnector attributeConnectors at: index - 1.
	connector2 := tableConnector attributeConnectors at: index.
	tableConnector attributeConnectors at: index put: connector1.
	tableConnector attributeConnectors at: index - 1 put: connector2.
	connectorList
		items: tableConnector attributeConnectors;
		selectIndex: index - 1
]

{ #category : #accessing }
RMDCSVImporter >> outputDataFrame [

	^ tableConnector
		  value: dataFrame
		  baseTime: nil
		  timeUnit: (timeUnitDropList selectedItem ifNil: [ RMDUnit day ])
		  withInterpolation: interpolateMissingValues state
]

{ #category : #accessing }
RMDCSVImporter >> outputDataSource [

	^ RMDDataSource dataFrame: self outputDataFrame
]

{ #category : #operations }
RMDCSVImporter >> removeConnector [

	connectorList selectedItem ifNotNil: [ :connector |
		| index |
		tableConnector removeAttributeConnectorAtAttribute: connector attribute.
		index := connectorList selection selectedIndex.
		connectorList
			items: tableConnector attributeConnectors;
			selectIndex: index.
		self updateTable ]
]

{ #category : #accessing }
RMDCSVImporter >> title [

	^ 'Data Table Importer'
]

{ #category : #updating }
RMDCSVImporter >> updateButtons [

	dataFrame
		ifNil: [
			{
				addConnectorButton.
				removeConnectorButton.
				moveUpConnectorButton.
				moveDownConnectorButton.
				editConnectorButton } do: #disable ]
		ifNotNil: [
			addConnectorButton enable.
			removeConnectorButton enabled: connectorList selectedItem notNil.
			moveUpConnectorButton enabled:
				connectorList selection selectedIndex > 1.
			moveDownConnectorButton enabled:
				(connectorList selection selectedIndex
					 between: 1
					 and: connectorList items size - 1).
			editConnectorButton enabled: connectorList selectedItem notNil ]
]

{ #category : #updating }
RMDCSVImporter >> updateConnectors [

	yearDropList items: { nil } , dataFrame columnNames.
	yearDropList selectedIndex = 0 ifTrue: [ yearDropList selectIndex: 1 ].
	monthDropList items: { nil } , dataFrame columnNames.
	monthDropList selectedIndex = 0 ifTrue: [
		monthDropList selectIndex: 1 ].
	monthField number ifNil: [
		monthField number:
			(tableConnector month ifRMDCalendarColumnConnector: [ 1 ]) ].
	dayDropList items: { nil } , dataFrame columnNames.
	dayDropList selectedIndex = 0 ifTrue: [ dayDropList selectIndex: 1 ].
	dayField number ifNil: [
		dayField number:
			(tableConnector day ifRMDCalendarColumnConnector: [ 1 ]) ].
	hourDropList items: { nil } , dataFrame columnNames.
	hourDropList selectedIndex = 0 ifTrue: [ hourDropList selectIndex: 1 ].
	hourField number ifNil: [
		hourField number:
			(tableConnector hour ifRMDCalendarColumnConnector: [ 0 ]) ].
	minuteDropList items: { nil } , dataFrame columnNames.
	minuteDropList selectedIndex = 0 ifTrue: [
		minuteDropList selectIndex: 1 ].
	minuteField number ifNil: [
		minuteField number:
			(tableConnector minute ifRMDCalendarColumnConnector: [ 0 ]) ].
	secondDropList items: { nil } , dataFrame columnNames.
	secondDropList selectedIndex = 0 ifTrue: [
		secondDropList selectIndex: 1 ].
	secondField number ifNil: [
		secondField number:
			(tableConnector second ifRMDCalendarColumnConnector: [ 0 ]) ].
	timeDropList items: { nil } , dataFrame columnNames.
	self updateButtons
]

{ #category : #updating }
RMDCSVImporter >> updateDataFrame [

	[
	| reader |
	reader := DataFrameCsvReader new.
	reader shouldInferTypes: false.
	dataFrame := (reader readFrom: fileReference) forceNumericOrNil.
	dataFrame ]
		on: Error
		do: [ :ex |
			fileReference := nil.
			dataFrame ifNil: [ ^ self ].
			dataFrame := nil.
			tableConnector := nil ].
	tableConnector := RMDTableConnector new.
	self updateSourceTable
]

{ #category : #updating }
RMDCSVImporter >> updateDayConnector [

	tableConnector day:
		(dayDropList selectedItem ifNil: [ dayField number ]).
	dayDropList selectedItem
		ifNil: [
			dayField
				enable;
				color: Color white ]
		ifNotNil: [
			dayField
				disable;
				color: self disableColor ].
	self updateTable
]

{ #category : #updating }
RMDCSVImporter >> updateHourConnector [

	tableConnector hour:
		(hourDropList selectedItem ifNil: [ hourField number ]).
	hourDropList selectedItem
		ifNil: [
			hourField
				enable;
				color: Color white ]
		ifNotNil: [
			hourField
				disable;
				color: self disableColor ].
	self updateTable
]

{ #category : #updating }
RMDCSVImporter >> updateMinuteConnector [

	tableConnector minute:
		(minuteDropList selectedItem ifNil: [ minuteField number ]).
	minuteDropList selectedItem
		ifNil: [
			minuteField
				enable;
				color: Color white ]
		ifNotNil: [
			minuteField
				disable;
				color: self disableColor ].
	self updateTable
]

{ #category : #updating }
RMDCSVImporter >> updateMonthConnector [

	tableConnector month:
		(monthDropList selectedItem ifNil: [ monthField number ]).
	monthDropList selectedItem
		ifNil: [
			monthField
				enable;
				color: Color white ]
		ifNotNil: [
			monthField
				disable;
				color: self disableColor ].
	self updateTable
]

{ #category : #updating }
RMDCSVImporter >> updateSecondConnector [

	tableConnector second:
		(secondDropList selectedItem ifNil: [ secondField number ]).
	secondDropList selectedItem
		ifNil: [
			secondField
				enable;
				color: Color white ]
		ifNotNil: [
			secondField
				disable;
				color: self disableColor ].
	self updateTable
]

{ #category : #updating }
RMDCSVImporter >> updateSourceTable [

	dataFrame
		ifNotNil: [
			sourceTable
				columns: (dataFrame columnNames collect: [ :name |
							 SpStringTableColumn
								 title: name
								 evaluated: [ :dataSeries | dataSeries at: name ] ]);
				items: dataFrame rows ]
		ifNil: [ sourceTable columns: Array new ].
	self updateConnectors
]

{ #category : #updating }
RMDCSVImporter >> updateTable [

	(dataFrame notNil and: [ tableConnector notNil ]) ifTrue: [
		self outputDataFrame
			ifNotNil: [ :newDataFrame |
				table
					columns: (newDataFrame columnNames collect: [ :name |
								 SpStringTableColumn
									 title: name
									 evaluated: [ :dataSeries | dataSeries at: name ] ]);
					items: newDataFrame rows.
				self validateTable
					ifTrue: [ table color: Color white ]
					ifFalse: [ table color: self errorColor ].
				(self window notNil and: [ self window isDialog ]) ifTrue: [
					self window buttons first enabled:
						(newDataFrame numberOfColumns > 1 and: [ self validateTable ]) ] ]
			ifNil: [ table color: self errorColor ] ]
]

{ #category : #updating }
RMDCSVImporter >> updateTimeConnector [

	tableConnector timeConnector:
		(RMDTimeColumnConnector columnName: timeDropList selectedItem).
	self updateTable
]

{ #category : #updating }
RMDCSVImporter >> updateYearConnector [

	yearDropList selectedItem
		ifNotNil: [ :name |
			dataFrame ifNotNil: [
				((dataFrame column: name) at: 1) >= 1000
					ifTrue: [
						baseYearField
							number: 0;
							color: self disableColor ]
					ifFalse: [ baseYearField color: Color white ] ].
			tableConnector year: name base: baseYearField number ]
		ifNil: [
			baseYearField color: Color white.
			baseYearField number ifNil: [ baseYearField number: 2000 ].
			tableConnector year: baseYearField number ].
	self updateTable
]

{ #category : #operations }
RMDCSVImporter >> useCalendarDates [

	tableConnector usesCalendarConnectors: true.
	timeDropList disable.
	{
		yearDropList.
		baseYearField.
		monthDropList.
		monthField.
		dayDropList.
		dayField.
		hourDropList.
		hourField.
		minuteDropList.
		minuteField.
		secondDropList.
		secondField } do: #enable
]

{ #category : #operations }
RMDCSVImporter >> useElapsedTime [

	tableConnector usesCalendarConnectors: false.
	timeDropList enable.
	{
		yearDropList.
		baseYearField.
		monthDropList.
		monthField.
		dayDropList.
		dayField.
		hourDropList.
		hourField.
		minuteDropList.
		minuteField.
		secondDropList.
		secondField } do: #disable
]

{ #category : #validating }
RMDCSVImporter >> validateTable [

	table items inject: Float negativeInfinity into: [ :last :row |
		| time |
		time := row atIndex: 1.
		time <= last ifTrue: [ ^ false ].
		time ].
	^ table items allSatisfy: [ :row | row allSatisfy: #isNumber ]
]
