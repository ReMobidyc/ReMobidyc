Class {
	#name : #RMDAbstractColumnConnnector,
	#superclass : #Object,
	#instVars : [
		'columnName'
	],
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #'instance creation' }
RMDAbstractColumnConnnector class >> columnName: aString [

	^ self new
		  columnName: aString;
		  yourself
]

{ #category : #testing }
RMDAbstractColumnConnnector class >> isAbstract [

	^ self = RMDAbstractColumnConnnector
]

{ #category : #accessing }
RMDAbstractColumnConnnector >> columnName [

	^ columnName
]

{ #category : #accessing }
RMDAbstractColumnConnnector >> columnName: aString [

	columnName := aString
]

{ #category : #accessing }
RMDAbstractColumnConnnector >> installTo: aRMDTableConnector [

	^ self subclassResponsibility
]

{ #category : #evaluating }
RMDAbstractColumnConnnector >> value: aDataFrame [

	^ aDataFrame column: self columnName ifAbsent: [ nil ]
]
