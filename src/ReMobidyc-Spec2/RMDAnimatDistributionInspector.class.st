Class {
	#name : #RMDAnimatDistributionInspector,
	#superclass : #RMDDistributionInspector,
	#traits : 'TRMDAnimatObservatory',
	#classTraits : 'TRMDAnimatObservatory classTrait',
	#instVars : [
		'#animat => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #accessing }
RMDAnimatDistributionInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatDistributionInspector >> animat: aString [
	animat := aString
]

{ #category : #initialization }
RMDAnimatDistributionInspector >> initialize [
	super initialize.
	self property: #animat whenChangedDo: [ self updateImage ]
]
