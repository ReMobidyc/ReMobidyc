Class {
	#name : #RMDMonthColumnConnector,
	#superclass : #RMDCalendarColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDMonthColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector month: self
]
