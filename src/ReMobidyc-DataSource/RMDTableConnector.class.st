Class {
	#name : #RMDTableConnector,
	#superclass : #Object,
	#instVars : [
		'attributeConnectors',
		'year',
		'month',
		'day',
		'hour',
		'minute',
		'second',
		'usesCalendarConnectors',
		'timeConnector'
	],
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'adding - removing' }
RMDTableConnector >> addAttributeConnector: aRMDAttributeColumnConnector [

	^ self
		  addAttributeConnector: aRMDAttributeColumnConnector
		  ifPresent: [  ]
]

{ #category : #'adding - removing' }
RMDTableConnector >> addAttributeConnector: aRMDAttributeColumnConnector ifPresent: aBlock [

	(attributeConnectors anySatisfy: [ :connector |
		 connector attribute = aRMDAttributeColumnConnector attribute ])
		ifTrue: [ ^ aBlock cull: aRMDAttributeColumnConnector ].
	attributeConnectors := attributeConnectors copyWith:
		                       aRMDAttributeColumnConnector
]

{ #category : #'adding - removing' }
RMDTableConnector >> addAttributeConnectorAt: aString attribute: anotherString unit: aRMDUnit interpolation: aRMDDataInterpolation [

	self
		addAttributeConnectorAt: aString
		attribute: anotherString
		unit: aRMDUnit
		interpolation: aRMDDataInterpolation
		ifPresent: [  ]
]

{ #category : #'adding - removing' }
RMDTableConnector >> addAttributeConnectorAt: aString attribute: anotherString unit: aRMDUnit interpolation: aRMDDataInterpolation ifPresent: aBlock [

	self
		addAttributeConnector: (RMDAttributeColumnConnector
				 columnName: aString
				 attribute: anotherString
				 unit: aRMDUnit
				 interpolation: aRMDDataInterpolation)
		ifPresent: aBlock
]

{ #category : #accessing }
RMDTableConnector >> attributeConnectors [

	^ attributeConnectors
]

{ #category : #accessing }
RMDTableConnector >> day [

	^ day
]

{ #category : #accessing }
RMDTableConnector >> day: anIntegerOrStringOrRMDDayColumnConnectorOrNil [

	day := (anIntegerOrStringOrRMDDayColumnConnectorOrNil isString
		        ifTrue: [
			        RMDDayColumnConnector columnName:
				        anIntegerOrStringOrRMDDayColumnConnectorOrNil ]
		        ifFalse: [ anIntegerOrStringOrRMDDayColumnConnectorOrNil ])
		       ifNil: [ day ]
]

{ #category : #accessing }
RMDTableConnector >> hour [

	^ hour
]

{ #category : #accessing }
RMDTableConnector >> hour: anIntegerOrStringOrRMDHourColumnConnectorOrNil [

	hour := (anIntegerOrStringOrRMDHourColumnConnectorOrNil isString
		         ifTrue: [
			         RMDDayColumnConnector columnName:
				         anIntegerOrStringOrRMDHourColumnConnectorOrNil ]
		         ifFalse: [ anIntegerOrStringOrRMDHourColumnConnectorOrNil ])
		        ifNil: [ hour ]
]

{ #category : #accessing }
RMDTableConnector >> inferTimeUnit [

	second isNumber ifFalse: [ ^ RMDUnit second ].
	minute isNumber ifFalse: [ ^ RMDUnit minute ].
	hour isNumber ifFalse: [ ^ RMDUnit hour ].
	day isNumber ifFalse: [ ^ RMDUnit day ].
	month isNumber ifFalse: [ ^ RMDUnit day ].
	year isNumber ifFalse: [ ^ RMDUnit day ]
]

{ #category : #initialization }
RMDTableConnector >> initialize [

	super initialize.
	attributeConnectors := Array new.
	usesCalendarConnectors := false.
	year := 2000.
	month := 1.
	day := 1.
	hour := 0.
	minute := 0.
	second := 0
]

{ #category : #evaluating }
RMDTableConnector >> interpolateDataFrame: aDataFrame [

	attributeConnectors doWithIndex: [ :connector :index |
		connector interpolation
			interpolateDataFrame: aDataFrame
			columnAt: index + 1 ].
	^ aDataFrame
]

{ #category : #accessing }
RMDTableConnector >> minute [

	^ minute
]

{ #category : #accessing }
RMDTableConnector >> minute: anIntegerOrStringOrRMDMinuteColumnConnectorOrNil [

	minute := (anIntegerOrStringOrRMDMinuteColumnConnectorOrNil isString
		           ifTrue: [
			           RMDDayColumnConnector columnName:
				           anIntegerOrStringOrRMDMinuteColumnConnectorOrNil ]
		           ifFalse: [
		           anIntegerOrStringOrRMDMinuteColumnConnectorOrNil ])
		          ifNil: [ minute ]
]

{ #category : #accessing }
RMDTableConnector >> month [

	^ month
]

{ #category : #accessing }
RMDTableConnector >> month: anIntegerOrStringOrRMDMonthColumnConnectorOrNil [

	month := (anIntegerOrStringOrRMDMonthColumnConnectorOrNil isString
		          ifTrue: [
			          RMDDayColumnConnector columnName:
				          anIntegerOrStringOrRMDMonthColumnConnectorOrNil ]
		          ifFalse: [
		          anIntegerOrStringOrRMDMonthColumnConnectorOrNil ]) ifNil: [
		         month ]
]

{ #category : #'adding - removing' }
RMDTableConnector >> removeAttributeConnectorAtAttribute: aString [

	attributeConnectors := attributeConnectors reject: [ :connector |
		                       connector attribute = aString ]
]

{ #category : #accessing }
RMDTableConnector >> second [

	^ second
]

{ #category : #accessing }
RMDTableConnector >> second: anIntegerOrStringOrRMDSecondColumnConnectorOrNil [

	second := (anIntegerOrStringOrRMDSecondColumnConnectorOrNil isString
		           ifTrue: [
			           RMDDayColumnConnector columnName:
				           anIntegerOrStringOrRMDSecondColumnConnectorOrNil ]
		           ifFalse: [
		           anIntegerOrStringOrRMDSecondColumnConnectorOrNil ])
		          ifNil: [ second ]
]

{ #category : #evaluating }
RMDTableConnector >> timeColumnFrom: aDataFrame baseTime: aDateAndTimeOrNil timeUnit: aRMDUnitOrNil [

	^ self usesCalendarConnectors
		  ifTrue: [
			  self
				  timeColumnWithCalendarConnectorsFrom: aDataFrame
				  baseTime: aDateAndTimeOrNil
				  timeUnit: aRMDUnitOrNil ]
		  ifFalse: [
			  self
				  timeColumnWithTimeConnectorFrom: aDataFrame
				  timeUnit: aRMDUnitOrNil ]
]

{ #category : #evaluating }
RMDTableConnector >> timeColumnWithCalendarConnectorsFrom: aDataFrame baseTime: aDateAndTimeOrNil timeUnit: aRMDUnitOrNil [

	| y mo d h mi s epoch unit |
	y := year ifRMDCalendarColumnConnector: [ :c | c value: aDataFrame ].
	mo := month ifRMDCalendarColumnConnector: [ :c | c value: aDataFrame ].
	d := day ifRMDCalendarColumnConnector: [ :c | c value: aDataFrame ].
	h := hour ifRMDCalendarColumnConnector: [ :c | c value: aDataFrame ].
	mi := minute ifRMDCalendarColumnConnector: [ :c | c value: aDataFrame ].
	s := second ifRMDCalendarColumnConnector: [ :c | c value: aDataFrame ].
	epoch := aDateAndTimeOrNil.
	unit := aRMDUnitOrNil ifNil: [ self inferTimeUnit ].
	^ [
	  (DataSeries newFrom:
			   ((1 to: aDataFrame size) collect: [ :rowIndex |
					    | datetime |
					    datetime := DateAndTime
						                year: (y isNumber
								                 ifTrue: [ y ]
								                 ifFalse: [ y at: rowIndex ])
						                month: (mo isNumber
								                 ifTrue: [ mo ]
								                 ifFalse: [ mo at: rowIndex ])
						                day: (d isNumber
								                 ifTrue: [ d ]
								                 ifFalse: [ d at: rowIndex ])
						                hour: (h isNumber
								                 ifTrue: [ h ]
								                 ifFalse: [ h at: rowIndex ])
						                minute: (mi isNumber
								                 ifTrue: [ mi ]
								                 ifFalse: [ mi at: rowIndex ])
						                second: (s isNumber
								                 ifTrue: [ s ]
								                 ifFalse: [ s at: rowIndex ]).
					    epoch ifNil: [ epoch := datetime ].
					    unit fromSI: (datetime - epoch) asSeconds ]))
		  name: 'time[' , unit printString , ']';
		  yourself ]
		  on: Error
		  do: [ :ex | ^ nil ]
]

{ #category : #evaluating }
RMDTableConnector >> timeColumnWithTimeConnectorFrom: aDataFrame timeUnit: aRMDUnitOrNil [

	^ (aDataFrame column: timeConnector columnName ifAbsent: [ nil ])
		  ifNotNil: [ :timeColumn |
			  (DataSeries newFrom:
					   ((1 to: aDataFrame size) collect: [ :index |
							    timeColumn at: index ]))
				  name:
					  'time['
					  , (aRMDUnitOrNil ifNotNil: #printString ifNil: [ 'day' ]) , ']';
				  yourself ]
]

{ #category : #accessing }
RMDTableConnector >> timeConnector [

	^ timeConnector
]

{ #category : #accessing }
RMDTableConnector >> timeConnector: aRMDTimeColumnConnector [
	timeConnector := aRMDTimeColumnConnector
]

{ #category : #accessing }
RMDTableConnector >> usesCalendarConnectors [

	^ usesCalendarConnectors or: [ timeConnector isNil ]
]

{ #category : #accessing }
RMDTableConnector >> usesCalendarConnectors: aBoolean [

	usesCalendarConnectors := aBoolean
]

{ #category : #evaluating }
RMDTableConnector >> value: aDataFrame baseTime: aDateAndTimeOrNil timeUnit: aRMDUnitOrNil withInterpolation: aBoolean [

	| dataFrame |
	dataFrame := DataFrame new: aDataFrame numberOfRows @ 0.
	dataFrame addColumn: ((self
			  timeColumnFrom: aDataFrame
			  baseTime: aDateAndTimeOrNil
			  timeUnit: aRMDUnitOrNil) ifNil: [ ^ nil ]).
	attributeConnectors do: [ :connector |
		dataFrame addColumn: (connector value: aDataFrame) ].
	aBoolean ifTrue: [ dataFrame := self interpolateDataFrame: dataFrame ].
	^ dataFrame
]

{ #category : #accessing }
RMDTableConnector >> year [

	^ year
]

{ #category : #accessing }
RMDTableConnector >> year: anIntegerOrStringOrRMDYearColumnConnectorOrNil [

	year := (anIntegerOrStringOrRMDYearColumnConnectorOrNil isString
		         ifTrue: [
			         RMDDayColumnConnector columnName:
				         anIntegerOrStringOrRMDYearColumnConnectorOrNil ]
		         ifFalse: [ anIntegerOrStringOrRMDYearColumnConnectorOrNil ])
		        ifNil: [ year ]
]

{ #category : #accessing }
RMDTableConnector >> year: aStringOrNil base: anIntegerOrNil [

	year := (aStringOrNil
		         ifNotNil: [
			         RMDYearColumnConnector
				         columnName: aStringOrNil
				         baseYear: anIntegerOrNil ]
		         ifNil: [ anIntegerOrNil ]) ifNil: [ year ]
]
