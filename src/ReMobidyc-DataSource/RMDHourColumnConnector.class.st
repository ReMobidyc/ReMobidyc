Class {
	#name : #RMDHourColumnConnector,
	#superclass : #RMDTimeColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDHourColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector hour: self
]
