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

{ #category : #accessing }
RMDTableConnector >> day [

	^ day
]

{ #category : #accessing }
RMDTableConnector >> day: anIntegerOrRMDDayColumnConnector [

	day := anIntegerOrRMDDayColumnConnector
]

{ #category : #accessing }
RMDTableConnector >> hour [

	^ hour
]

{ #category : #accessing }
RMDTableConnector >> hour: anIntegerOrRMDHourColumnConnector [

	hour := anIntegerOrRMDHourColumnConnector
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
RMDTableConnector >> minute: anIntegerOrRMDMinuteColumnConnector [

	minute := anIntegerOrRMDMinuteColumnConnector
]

{ #category : #accessing }
RMDTableConnector >> month [

	^ month
]

{ #category : #accessing }
RMDTableConnector >> month: anIntegerOrRMDMonthColumnConnector [

	month := anIntegerOrRMDMonthColumnConnector
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
RMDTableConnector >> second: anIntegerOrRMDSecondColumnConnector [

	second := anIntegerOrRMDSecondColumnConnector
]

{ #category : #evaluating }
RMDTableConnector >> timeFrom: aDataSeries baseTime: aDateAndTime unit: aRMDUnit [

	^ aRMDUnit fromSI: ((DateAndTime
			    year:
			    (year ifRMDTimeColumnConnector: [ :c | c value: aDataSeries ])
			    month:
			    (month ifRMDTimeColumnConnector: [ :c | c value: aDataSeries ])
			    day:
			    (day ifRMDTimeColumnConnector: [ :c | c value: aDataSeries ])
			    hour:
			    (hour ifRMDTimeColumnConnector: [ :c | c value: aDataSeries ])
			    minute:
			    (minute ifRMDTimeColumnConnector: [ :c | c value: aDataSeries ])
			    second:
			    (second ifRMDTimeColumnConnector: [ :c | c value: aDataSeries ]))
		   - aDateAndTime) asSeconds
]

{ #category : #accessing }
RMDTableConnector >> timeUnit [

	second isNumber ifFalse: [ ^ RMDUnit second ].
	minute isNumber ifFalse: [ ^ RMDUnit minute ].
	hour isNumber ifFalse: [ ^ RMDUnit hour ].
	day isNumber ifFalse: [ ^ RMDUnit day ].
	month isNumber ifFalse: [ ^ RMDUnit day ].
	year isNumber ifFalse: [ ^ RMDUnit day ]
]

{ #category : #evaluating }
RMDTableConnector >> value: aDataSeries baseTime: aDateAndTime [

	^ DataSeries newFrom: (Array streamContents: [ :stream |
			   | unit label |
			   unit := self timeUnit.
			   label := 'time[' , unit printString , ']'.
			   stream nextPut: label
				   ->
				   (self timeFrom: aDataSeries baseTime: aDateAndTime unit: unit).
			   attributeConnectors do: [ :connector |
				   stream nextPut: connector key -> (connector value: aDataSeries) ] ])
]

{ #category : #accessing }
RMDTableConnector >> year [

	^ year
]

{ #category : #accessing }
RMDTableConnector >> year: anIntegerOrRMDYearColumnConnector [

	year := anIntegerOrRMDYearColumnConnector
]
