Class {
	#name : #RMDDayColumnConnector,
	#superclass : #RMDCalendarColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDDayColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector day: self
]
