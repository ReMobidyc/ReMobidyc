Class {
	#name : 'RMDIdColumn',
	#superclass : 'RMDTabularColumn',
	#category : 'ReMobidyc-Spec2-Tabulars',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Tabulars'
}

{ #category : 'enumerating' }
RMDIdColumn >> ifOnChartDo: aBlock [

	
]

{ #category : 'accessing' }
RMDIdColumn >> title [

	^ title ifNil: [ title := 'ID' ]
]

{ #category : 'accessing' }
RMDIdColumn >> value: aRow [

	^ aRow at: #id ifAbsent: [ '' ]
]
