Class {
	#name : #RMDSecondColumnConnector,
	#superclass : #RMDTimeColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDSecondColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector second: self
]
