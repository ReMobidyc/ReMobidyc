Class {
	#name : 'RMDPatchXColumn',
	#superclass : 'RMDTabularColumn',
	#instVars : [
		'unit'
	],
	#category : 'ReMobidyc-Spec2-Tabulars',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Tabulars'
}

{ #category : 'instance creation' }
RMDPatchXColumn class >> unit: aRMDUnit [

	^ self new
		  unit: aRMDUnit;
		  yourself
]

{ #category : 'enumerating' }
RMDPatchXColumn >> ifOnChartDo: aBlock [

	
]

{ #category : 'accessing' }
RMDPatchXColumn >> unit [

	^ unit
]

{ #category : 'accessing' }
RMDPatchXColumn >> unit: aRMDUnit [

	unit := aRMDUnit.
	title := 'center x [' , unit printString , ']'
]

{ #category : 'accessing' }
RMDPatchXColumn >> value: aRow [

	^ aRow
		  at: 'x'
		  ifPresent: [ :value | unit fromSI: value ]
		  ifAbsent: [ '' ]
]
