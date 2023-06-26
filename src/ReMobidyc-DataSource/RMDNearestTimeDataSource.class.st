Class {
	#name : #RMDNearestTimeDataSource,
	#superclass : #RMDAbstractDataSource,
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #private }
RMDNearestTimeDataSource >> atTime: aNumber with: anArrayOfDictionary [

	| d0 d1 t0 t1 |
	d0 := anArrayOfDictionary first.
	d1 := anArrayOfDictionary second.
	t0 := d0 at: 'time'.
	t1 := d1 at: 'time'.
	^ (aNumber - t0) abs < (aNumber - t1) abs
		  ifTrue: [ d0 ]
		  ifFalse: [ d1 ]
]
