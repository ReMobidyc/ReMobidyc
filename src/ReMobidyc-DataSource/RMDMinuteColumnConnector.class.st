Class {
	#name : #RMDMinuteColumnConnector,
	#superclass : #RMDCalendarColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDMinuteColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector minute: self
]
