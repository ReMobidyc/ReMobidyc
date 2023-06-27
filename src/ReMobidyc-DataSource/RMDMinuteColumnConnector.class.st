Class {
	#name : #RMDMinuteColumnConnector,
	#superclass : #RMDTimeColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDMinuteColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector minute: self
]
