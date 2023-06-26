Class {
	#name : #RMDLatestTimeDataSource,
	#superclass : #RMDAbstractDataSource,
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #private }
RMDLatestTimeDataSource >> atTime: aNumber with: anArrayOfDictionary [

	| t1 t2 accuracy |
	t1 := anArrayOfDictionary first at: 'time'.
	t2 := anArrayOfDictionary second at: 'time'.
	accuracy := (t2 - t1) abs * 1.0e-8.
	^ t2 - accuracy < aNumber
		  ifTrue: [ anArrayOfDictionary second ]
		  ifFalse: [ anArrayOfDictionary first ]
]
