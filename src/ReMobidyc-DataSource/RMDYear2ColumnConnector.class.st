Class {
	#name : #RMDYear2ColumnConnector,
	#superclass : #RMDTimeColumnConnector,
	#instVars : [
		'baseYear'
	],
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'instance creation' }
RMDYear2ColumnConnector class >> columnName: aString baseYear: anInteger [

	^ (self columnName: aString)
		  baseYear: anInteger;
		  yourself
]

{ #category : #accessing }
RMDYear2ColumnConnector >> baseYear [

	^ baseYear
]

{ #category : #accessing }
RMDYear2ColumnConnector >> baseYear: anInteger [

	baseYear := anInteger
]

{ #category : #accessing }
RMDYear2ColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector year: self
]
