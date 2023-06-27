Class {
	#name : #RMDYearColumnConnector,
	#superclass : #RMDTimeColumnConnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #accessing }
RMDYearColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector year: self
]
