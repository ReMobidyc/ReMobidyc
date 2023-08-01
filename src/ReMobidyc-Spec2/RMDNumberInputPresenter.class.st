Class {
	#name : #RMDNumberInputPresenter,
	#superclass : #SpNumberInputFieldPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#number => ObservableSlot',
		'#lastValidNumber => ObservableSlot',
		'#isNonZero',
		'#isNonNegative'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDNumberInputPresenter >> acceptNumber: aNumber [

	number := self isInteger
		          ifTrue: [ aNumber asInteger ]
		          ifFalse: [ aNumber asFloat ].
	(self isValidNumber: number)
		ifTrue: [
			lastValidNumber := number.
			self beOk ]
		ifFalse: [ self beError ]
]

{ #category : #api }
RMDNumberInputPresenter >> beNonNegative [

	isNonNegative := true
]

{ #category : #api }
RMDNumberInputPresenter >> beNonZero [

	isNonZero := true
]

{ #category : #api }
RMDNumberInputPresenter >> bePositive [

	isNonZero := true.
	isNonNegative := true
]

{ #category : #initialization }
RMDNumberInputPresenter >> initialize [

	super initialize.
	isNonZero := false.
	isNonNegative := false.
	self whenSubmitDo: [:t | self prettyPrint ]
]

{ #category : #private }
RMDNumberInputPresenter >> isValidNumber: aNumber [

	(aNumber isKindOf: self numberType) ifFalse: [ ^ false ].
	(isNonZero and: [ aNumber = 0 ]) ifTrue: [ ^ false ].
	(isNonNegative and: [ aNumber < 0 ]) ifTrue: [ ^ false ].
	^ true
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
	(self isValidNumber: number)
		ifTrue: [
			lastValidNumber := number.
			self beOk ]
		ifFalse: [ self beError ].
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
	(self isValidNumber: number)
		ifTrue: [
			self beOk.
			lastValidNumber := number ]
		ifFalse: [ self beError ] ]
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
