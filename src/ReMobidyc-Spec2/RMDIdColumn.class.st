Class {
	#name : #RMDIdColumn,
	#superclass : #RMDTabularColumn,
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #accessing }
RMDIdColumn >> title [

	^ title ifNil: [ title := 'ID' ]
]

{ #category : #accessing }
RMDIdColumn >> value: aRow [

	^ aRow at: #id ifAbsent: [ '' ]
]
