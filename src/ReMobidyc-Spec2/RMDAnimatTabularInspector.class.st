Class {
	#name : #RMDAnimatTabularInspector,
	#superclass : #RMDTabularInspector,
	#traits : 'TRMDAnimatObservatory',
	#classTraits : 'TRMDAnimatObservatory classTrait',
	#instVars : [
		'#animat => ObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #accessing }
RMDAnimatTabularInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatTabularInspector >> animat: aString [
	animat := aString
]

{ #category : #initialization }
RMDAnimatTabularInspector >> initialize [
	super initialize.
	self property: #animat whenChangedDo: [ self updateTable ]
]
