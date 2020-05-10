Class {
	#name : #RMDNumberInputPresenter,
	#superclass : #SpNumberInputFieldPresenter,
	#instVars : [
		'#number => SpObservableSlot',
		'#lastValidNumber => SpObservableSlot',
		'#parseFailureColor => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2'
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

{ #category : #private }
RMDNumberInputPresenter >> beOk [
	self color: self theme backgroundColor
]

{ #category : #private }
RMDNumberInputPresenter >> beParseFailure [
	self color: parseFailureColor
]

{ #category : #initialization }
RMDNumberInputPresenter >> initialize [
	super initialize.
	parseFailureColor := self theme backgroundColor
		mixed: 0.9
		with: Color red
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
			self beParseFailure.
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
