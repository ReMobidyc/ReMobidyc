Class {
	#name : #RMDPatchYColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'unit'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #'instance creation' }
RMDPatchYColumn class >> unit: aRMDUnit [

	^ self new
		  unit: aRMDUnit;
		  yourself
]

{ #category : #enumerating }
RMDPatchYColumn >> ifOnChartDo: aBlock [

	
]

{ #category : #accessing }
RMDPatchYColumn >> unit [

	^ unit
]

{ #category : #accessing }
RMDPatchYColumn >> unit: aRMDUnit [

	unit := aRMDUnit
]

{ #category : #accessing }
RMDPatchYColumn >> value: aRow [

	^ aRow
		  at: 'y'
		  ifPresent: [ :value | unit fromSI: value ]
		  ifAbsent: [ '' ]
]
