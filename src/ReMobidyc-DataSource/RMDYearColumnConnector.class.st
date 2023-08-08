Class {
	#name : #RMDYearColumnConnector,
	#superclass : #RMDCalendarColumnConnector,
	#instVars : [
		'baseYear'
	],
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'instance creation' }
RMDYearColumnConnector class >> columnName: aString baseYear: anInteger [

	^ (self columnName: aString)
		  baseYear: anInteger;
		  yourself
]

{ #category : #accessing }
RMDYearColumnConnector >> baseYear [

	^ baseYear
]

{ #category : #accessing }
RMDYearColumnConnector >> baseYear: anInteger [

	baseYear := anInteger
]

{ #category : #accessing }
RMDYearColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector year: self
]
