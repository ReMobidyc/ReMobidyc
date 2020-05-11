Class {
	#name : #RMDNumberInputPresenter,
	#superclass : #SpNumberInputFieldPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#number => SpObservableSlot',
		'#lastValidNumber => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDNumberInputPresenter >> acceptNumebr: aNumber [
	number := self isInteger
		ifTrue: [ aNumber asInteger ]
		ifFalse: [ aNumber asFloat ].
	lastValidNumber := number.
	self beOk.
	self accept: number printString
]

{ #category : #initialization }
RMDNumberInputPresenter >> initialize [
	super initialize.
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
	number := self isInteger
		ifTrue: [ aNumber asInteger ]
		ifFalse: [ aNumber asFloat ].
	lastValidNumber := number.
	self beOk.
	text := number printString
]

{ #category : #api }
RMDNumberInputPresenter >> text: aString [
	[ number := self isInteger
		ifTrue: [ aString asNumber asInteger ]
		ifFalse: [ aString asNumber asFloat ].
	self beOk.
	lastValidNumber := number.
	^ super text: number printString ]
		on: Error
		do: [ :ex | 
			self beError.
			number := nil.
			^ nil ]
]

{ #category : #'api-events' }
RMDNumberInputPresenter >> whenLastValidNumberChangedDo: aBlock [
	self property: #lastValidNumber whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDNumberInputPresenter >> whenNumberChangedDo: aBlock [
	self property: #number whenChangedDo: aBlock
]
