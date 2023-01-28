Class {
	#name : #RMDContext,
	#superclass : #Object,
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #private }
RMDContext >> checkRecursion: anObject do: aBlock onRecursion: errorBlock [

	| context |
	context := thisContext sender.
	[ context notNil ] whileTrue: [ 
		(context receiver == self and: [ 
			 context selector == #checkRecursion:do:onRecursion: and: [ 
				 context arguments first == anObject ] ]) ifTrue: [ 
			^ errorBlock cull: context sender ].
		context := context sender ].
	^ aBlock value
]
