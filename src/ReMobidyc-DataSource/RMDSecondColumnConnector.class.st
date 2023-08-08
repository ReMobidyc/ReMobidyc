Class {
	#name : #RMDSecondColumnConnector,
	#superclass : #RMDCalendarColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDSecondColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector second: self
]
