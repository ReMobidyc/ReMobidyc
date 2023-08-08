Class {
	#name : #RMDTimeColumnConnector,
	#superclass : #RMDAbstractColumnConnnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'instance creation' }
RMDTimeColumnConnector class >> columnName: aString attribute: anotherString unit: aRMDUnit interpolation: aRMDDataInterpolation [

	^ (self columnName: aString)
		  attribute: anotherString;
		  unit: aRMDUnit;
		  interpolation: aRMDDataInterpolation;
		  yourself
]

{ #category : #accessing }
RMDTimeColumnConnector >> installTo: aRMDTableConnector [

	aRMDTableConnector timeConnector: self
]
