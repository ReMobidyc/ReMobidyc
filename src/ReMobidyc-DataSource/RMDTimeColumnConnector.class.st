Class {
	#name : #RMDTimeColumnConnector,
	#superclass : #RMDAbstractColumnConnnector,
	#category : #'ReMobidyc-DataSource-Connectors'
}

{ #category : #testing }
RMDTimeColumnConnector class >> isAbstract [

	^ self = RMDTimeColumnConnector
]

{ #category : #controlling }
RMDTimeColumnConnector >> ifRMDTimeColumnConnector: aBlock [

	^ aBlock value: self
]