Class {
	#name : #RMDAnimatTabularInspector,
	#superclass : #RMDTabularInspector,
	#instVars : [
		'#animat => SpObservableSlot'
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

{ #category : #private }
RMDAnimatTabularInspector >> speciesDefinitionDo: aBlock [
	interpreter
		ifNotNil: [ interpreter animatDefinitionAt: animat ifPresent: aBlock ]
]
