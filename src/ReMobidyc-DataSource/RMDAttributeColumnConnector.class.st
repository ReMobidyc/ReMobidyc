Class {
	#name : #RMDAttributeColumnConnector,
	#superclass : #RMDAbstractColumnConnnector,
	#instVars : [
		'attribute',
		'unit',
		'interpolation'
	],
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'instance creation' }
RMDAttributeColumnConnector class >> columnName: aString attribute: anotherString unit: aRMDUnit interpolation: aRMDDataInterpolation [

	^ (self columnName: aString)
		  attribute: anotherString;
		  unit: aRMDUnit;
		  interpolation: aRMDDataInterpolation;
		  yourself
]

{ #category : #accessing }
RMDAttributeColumnConnector >> attribute [

	^ attribute
]

{ #category : #accessing }
RMDAttributeColumnConnector >> attribute: aString [

	attribute := aString
]

{ #category : #accessing }
RMDAttributeColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector addAttributeConnector: self
]

{ #category : #accessing }
RMDAttributeColumnConnector >> interpolation [

	^ interpolation
]

{ #category : #accessing }
RMDAttributeColumnConnector >> interpolation: aRMDDataInterpolation [

	interpolation := aRMDDataInterpolation
]

{ #category : #accessing }
RMDAttributeColumnConnector >> key [

	^ String streamContents: [ :stream |
		  stream
			  nextPutAll: attribute;
			  nextPut: $[.
		  unit printOn: stream.
		  stream
			  nextPut: $];
			  nextPutAll: interpolation name ]
]

{ #category : #accessing }
RMDAttributeColumnConnector >> unit [

	^ unit
]

{ #category : #accessing }
RMDAttributeColumnConnector >> unit: aRMDUnit [

	unit := aRMDUnit
]

{ #category : #evaluating }
RMDAttributeColumnConnector >> value: aDataFrame [

	^ (aDataFrame column: self columnName ifAbsent: [ nil ]) ifNotNil: [
		  :dataSeries |
		  dataSeries name:
			  attribute , '[' , unit printString , ']' , interpolation name ]
]
