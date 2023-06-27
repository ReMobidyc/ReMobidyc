Class {
	#name : #RMDDayColumnConnector,
	#superclass : #RMDTimeColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDDayColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector day: self
]
