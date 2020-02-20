Class {
	#name : #RMDRenderer,
	#superclass : #Object,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #drawing }
RMDRenderer >> draw: aRMDInterpreter on: aFormCanvas [
	^ self subclassResponsibility
]
