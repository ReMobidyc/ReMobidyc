Class {
	#name : #RMDAttributeConnector,
	#superclass : #RMDAbstractColumnConnnector,
	#instVars : [
		'attribute',
		'unit',
		'interpolation'
	],
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'instance creation' }
RMDAttributeConnector class >> columnName: aString attribute: anotherString unit: aRMDUnit interpolation: aRMDDataInterpolation [

	^ (self columnName: aString)
		  attribute: anotherString;
		  unit: aRMDUnit;
		  interpolation: aRMDDataInterpolation;
		  yourself
]

{ #category : #accessing }
RMDAttributeConnector >> attribute [

	^ attribute
]

{ #category : #accessing }
RMDAttributeConnector >> attribute: aString [

	attribute := aString
]

{ #category : #accessing }
RMDAttributeConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector addAttributeConnector: self
]

{ #category : #accessing }
RMDAttributeConnector >> interpolation [

	^ interpolation
]

{ #category : #accessing }
RMDAttributeConnector >> interpolation: aRMDDataInterpolation [

	interpolation := aRMDDataInterpolation
]

{ #category : #accessing }
RMDAttributeConnector >> key [

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
RMDAttributeConnector >> unit [

	^ unit
]

{ #category : #accessing }
RMDAttributeConnector >> unit: aRMDUnit [

	unit := aRMDUnit
]
