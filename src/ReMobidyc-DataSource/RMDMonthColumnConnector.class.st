Class {
	#name : #RMDMonthColumnConnector,
	#superclass : #RMDTimeColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDMonthColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector month: self
]
