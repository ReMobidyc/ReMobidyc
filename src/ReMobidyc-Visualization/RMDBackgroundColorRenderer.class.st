Class {
	#name : #RMDBackgroundColorRenderer,
	#superclass : #RMDBackgroundRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> black [
	^ self color: Color black
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> blue [
	^ self color: Color blue
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> color: aColor [
	^ self new
		color: aColor;
		yourself
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> red [
	^ self color: Color red
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> white [
	^ self color: Color white
]

{ #category : #drawing }
RMDBackgroundColorRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
	aCanvas fillColor: color
]
