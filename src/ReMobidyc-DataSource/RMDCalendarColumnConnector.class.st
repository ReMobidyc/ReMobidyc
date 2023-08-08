Class {
	#name : #RMDCalendarColumnConnector,
	#superclass : #RMDAbstractColumnConnnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #testing }
RMDCalendarColumnConnector class >> isAbstract [

	^ self = RMDCalendarColumnConnector
]

{ #category : #controlling }
RMDCalendarColumnConnector >> ifRMDCalendarColumnConnector: aBlock [

	^ aBlock cull: self
]

{ #category : #evaluating }
RMDCalendarColumnConnector >> value: aDataFrame [

	^ aDataFrame column: self columnName ifAbsent: [ nil ]
]
