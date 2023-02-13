Class {
	#name : #RMDTimeColumn,
	#superclass : #RMDTabularColumn,
	#instVars : [
		'unit'
	],
	#category : #'ReMobidyc-Spec2-Tabulars'
}

{ #category : #'instancce creation' }
RMDTimeColumn class >> unit: aRMDUnit [

	^ self new
		  unit: aRMDUnit;
		  yourself
]

{ #category : #accessing }
RMDTimeColumn >> unit [

	^ unit
]

{ #category : #accessing }
RMDTimeColumn >> unit: aRMDUnit [

	unit := aRMDUnit.
	title := 'time [' , unit printString , ']'
]

{ #category : #accessing }
RMDTimeColumn >> value: aRow [

	^ aRow
		  at: #time
		  ifPresent: [ :time | unit fromSI: time ]
		  ifAbsent: [ '' ]
]
