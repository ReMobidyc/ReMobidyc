Class {
	#name : #RMDHourColumnConnector,
	#superclass : #RMDCalendarColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDHourColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector hour: self
]
