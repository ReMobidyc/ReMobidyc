Class {
	#name : #RMDTimeColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'unit'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #accessing }
RMDTimeColumn >> unit [

	^ unit
]

{ #category : #accessing }
RMDTimeColumn >> unit: aRMDUnit [

	unit := aRMDUnit
]

{ #category : #accessing }
RMDTimeColumn >> value: aRow [

	^ aRow
		  at: #time
		  ifPresent: [ :time | unit fromSI: time ]
		  ifAbsent: [ '' ]
]
