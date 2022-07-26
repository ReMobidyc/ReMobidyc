Class {
	#name : #RMDAnimatRenderer,
	#superclass : #RMDRenderer,
	#instVars : [
		'animat'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDAnimatRenderer class >> on: aString [
	^ self new
		animat: aString;
		yourself
]

{ #category : #comparing }
RMDAnimatRenderer >> = anObject [

	^ super = anObject and: [ animat = anObject animat ]
]

{ #category : #accessing }
RMDAnimatRenderer >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatRenderer >> animat: aString [
	animat := aString
]

{ #category : #comparing }
RMDAnimatRenderer >> hash [

	^ super hash bitXor: animat hash
]

{ #category : #testing }
RMDAnimatRenderer >> isAnimatRendererFor: aString [
	^ animat = aString
]

{ #category : #rewriting }
RMDAnimatRenderer >> renameAnimat: aString to: anotherString [

	super renameAnimat: aString to: anotherString.
	animat = aString ifTrue: [ animat := anotherString ]
]
