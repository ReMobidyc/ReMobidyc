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
		'second'
	],
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'adding - removing' }
RMDTableConnector >> addAttributeConnector: aRMDAttributeColumnConnector [

	attributeConnectors := (attributeConnectors reject: [ :connector |
		                        connector attribute
		                        = aRMDAttributeColumnConnector attribute ])
		                       copyWith: aRMDAttributeColumnConnector
]

{ #category : #'adding - removing' }
RMDTableConnector >> addAttributeConnectorAt: aString attribute: anotherString unit: aRMDUnit interpolation: aRMDDataInterpolation [

	self addAttributeConnector: (RMDAttributeColumnConnector
			 columnName: aString
			 attribute: anotherString
			 unit: aRMDUnit
			 interpolation: aRMDDataInterpolation)
]

{ #category : #accessing }
RMDTableConnector >> day [

	^ day
]

{ #category : #accessing }
RMDTableConnector >> day: anIntegerOrStringOrRMDDayColumnConnectorOrNil [

	day := anIntegerOrStringOrRMDDayColumnConnectorOrNil isString
		       ifTrue: [
			       RMDDayColumnConnector columnName:
				       anIntegerOrStringOrRMDDayColumnConnectorOrNil ]
		       ifFalse: [ anIntegerOrStringOrRMDDayColumnConnectorOrNil ]
]

{ #category : #accessing }
RMDTableConnector >> hour [

	^ hour
]

{ #category : #accessing }
RMDTableConnector >> hour: anIntegerOrStringOrRMDHourColumnConnectorOrNil [

	hour := anIntegerOrStringOrRMDHourColumnConnectorOrNil isString
		        ifTrue: [
			        RMDDayColumnConnector columnName:
				        anIntegerOrStringOrRMDHourColumnConnectorOrNil ]
		        ifFalse: [ anIntegerOrStringOrRMDHourColumnConnectorOrNil ]
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
	year := 2000.
	month := 1.
	day := 1.
	hour := 0.
	minute := 0.
	second := 0
]

{ #category : #accessing }
RMDTableConnector >> minute [

	^ minute
]

{ #category : #accessing }
RMDTableConnector >> minute: anIntegerOrStringOrRMDMinuteColumnConnectorOrNil [

	minute := anIntegerOrStringOrRMDMinuteColumnConnectorOrNil isString
		          ifTrue: [
			          RMDDayColumnConnector columnName:
				          anIntegerOrStringOrRMDMinuteColumnConnectorOrNil ]
		          ifFalse: [
		          anIntegerOrStringOrRMDMinuteColumnConnectorOrNil ]
]

{ #category : #accessing }
RMDTableConnector >> month [

	^ month
]

{ #category : #accessing }
RMDTableConnector >> month: anIntegerOrStringOrRMDMonthColumnConnectorOrNil [

	month := anIntegerOrStringOrRMDMonthColumnConnectorOrNil isString
		         ifTrue: [
			         RMDDayColumnConnector columnName:
				         anIntegerOrStringOrRMDMonthColumnConnectorOrNil ]
		         ifFalse: [ anIntegerOrStringOrRMDMonthColumnConnectorOrNil ]
]

{ #category : #'adding - removing' }
RMDTableConnector >> removeAttributeConnectorAt: aString [

	attributeConnectors := attributeConnectors reject: [ :connector |
		                       connector columnName = aString ]
]

{ #category : #accessing }
RMDTableConnector >> second [

	^ second
]

{ #category : #accessing }
RMDTableConnector >> second: anIntegerOrStringOrRMDSecondColumnConnectorOrNil [

	second := anIntegerOrStringOrRMDSecondColumnConnectorOrNil isString
		          ifTrue: [
			          RMDDayColumnConnector columnName:
				          anIntegerOrStringOrRMDSecondColumnConnectorOrNil ]
		          ifFalse: [
		          anIntegerOrStringOrRMDSecondColumnConnectorOrNil ]
]

{ #category : #evaluating }
RMDTableConnector >> timeColumnFrom: aDataFrame baseTime: aDateAndTimeOrNil timeUnit: aRMDUnitOrNil [

	| y mo d h mi s epoch unit |
	y := year ifRMDTimeColumnConnector: [ :c | c value: aDataFrame ].
	mo := month ifRMDTimeColumnConnector: [ :c | c value: aDataFrame ].
	d := day ifRMDTimeColumnConnector: [ :c | c value: aDataFrame ].
	h := hour ifRMDTimeColumnConnector: [ :c | c value: aDataFrame ].
	mi := minute ifRMDTimeColumnConnector: [ :c | c value: aDataFrame ].
	s := second ifRMDTimeColumnConnector: [ :c | c value: aDataFrame ].
	epoch := aDateAndTimeOrNil.
	unit := aRMDUnitOrNil ifNil: [ self inferTimeUnit ].
	^ (DataSeries newFrom:
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
		  yourself
]

{ #category : #evaluating }
RMDTableConnector >> value: aDataFrame baseTime: aDateAndTimeOrNil timeUnit: aRMDUnitOrNil [

	| dataFrame |
	dataFrame := DataFrame new: aDataFrame numberOfRows @ 0.
	dataFrame addColumn: (self
			 timeColumnFrom: aDataFrame
			 baseTime: aDateAndTimeOrNil
			 timeUnit: aRMDUnitOrNil).
	attributeConnectors do: [ :connector |
		dataFrame addColumn: (connector value: aDataFrame) ].
	^ dataFrame
]

{ #category : #accessing }
RMDTableConnector >> year [

	^ year
]

{ #category : #accessing }
RMDTableConnector >> year: anIntegerOrStringOrRMDYearColumnConnectorOrNil [

	year := anIntegerOrStringOrRMDYearColumnConnectorOrNil isString
		        ifTrue: [
			        RMDDayColumnConnector columnName:
				        anIntegerOrStringOrRMDYearColumnConnectorOrNil ]
		        ifFalse: [ anIntegerOrStringOrRMDYearColumnConnectorOrNil ]
]
