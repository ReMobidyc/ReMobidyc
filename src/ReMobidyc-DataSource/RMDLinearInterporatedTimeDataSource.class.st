Class {
	#name : #RMDLinearInterporatedTimeDataSource,
	#superclass : #RMDAbstractDataSource,
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #private }
RMDLinearInterporatedTimeDataSource >> atTime: aNumber with: anArrayOfDictionary [

	| d0 d1 t0 t1 r0 r1 d |
	d0 := anArrayOfDictionary first.
	d1 := anArrayOfDictionary second.
	t0 := d0 at: 'time'.
	t1 := d1 at: 'time'.
	r0 := (aNumber - t0) asFloat / (t1 - t0).
	r0 <= 0.0 ifTrue: [ ^ d0 ].
	r0 >= 1.0 ifTrue: [ ^ d1 ].
	r1 := 1.0 - r0.
	d := Dictionary new: anArrayOfDictionary first size.
	d0 keysDo: [ :column |
		d at: column put: (d0 at: column) * r1 + ((d1 at: column) * r0) ].
	^ d
]
