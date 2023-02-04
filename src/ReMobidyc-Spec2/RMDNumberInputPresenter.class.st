Class {
	#name : #RMDNumberInputPresenter,
	#superclass : #SpNumberInputFieldPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#number => ObservableSlot',
		'#lastValidNumber => ObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDNumberInputPresenter >> acceptNumber: aNumber [

	number := self isInteger
		          ifTrue: [ aNumber asInteger ]
		          ifFalse: [ aNumber asFloat ].
	lastValidNumber := number.
	self beOk
]

{ #category : #initialization }
RMDNumberInputPresenter >> initialize [

	super initialize.
	self whenSubmitDo: [:t | self prettyPrint ]
]

{ #category : #api }
RMDNumberInputPresenter >> lastValidNumber [
	^ lastValidNumber
]

{ #category : #api }
RMDNumberInputPresenter >> number [
	^ number
]

{ #category : #api }
RMDNumberInputPresenter >> number: aNumber [

	number := aNumber ifNil: [ 0 ] ifNotNil: [ 
		          self isInteger
			          ifTrue: [ aNumber asInteger ]
			          ifFalse: [ aNumber asFloat ] ].
	lastValidNumber := number.
	self beOk.
	super text: aNumber printString
]

{ #category : #api }
RMDNumberInputPresenter >> prettyPrint [

	self number: self number
]

{ #category : #api }
RMDNumberInputPresenter >> text: aString [

	[ 
	number := self isInteger
		          ifTrue: [ aString asNumber asInteger ]
		          ifFalse: [ aString asNumber asFloat ].
	self beOk.
	lastValidNumber := number ]
		on: Error
		do: [ :ex | 
			self beError.
			number := nil ].
	^ super text: aString
]

{ #category : #'api-events' }
RMDNumberInputPresenter >> whenLastValidNumberChangedDo: aBlock [
	self property: #lastValidNumber whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDNumberInputPresenter >> whenNumberChangedDo: aBlock [

	self whenTextChangedDo: [ :txt | aBlock cull: self number ]
]
