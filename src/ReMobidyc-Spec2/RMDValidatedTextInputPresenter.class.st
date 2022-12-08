Class {
	#name : #RMDValidatedTextInputPresenter,
	#superclass : #SpTextInputFieldPresenter,
	#traits : 'TRMDPresenter + TRMDTemplateMenu',
	#classTraits : 'TRMDPresenter classTrait + TRMDTemplateMenu classTrait',
	#instVars : [
		'#validation => ObservableSlot',
		'#lastValidText => ObservableSlot',
		'#invalidIsWarning => ObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDValidatedTextInputPresenter >> beInvalid [
	self color: self invalidColor
]

{ #category : #initialization }
RMDValidatedTextInputPresenter >> initialize [
	super initialize.
	invalidIsWarning := false
]

{ #category : #api }
RMDValidatedTextInputPresenter >> invalidColor [
	^ invalidIsWarning
		ifTrue: [ self warningColor ]
		ifFalse: [ self errorColor ]
]

{ #category : #api }
RMDValidatedTextInputPresenter >> invalidIsWarning [
	^ invalidIsWarning
]

{ #category : #api }
RMDValidatedTextInputPresenter >> invalidIsWarning: aBoolean [
	invalidIsWarning := aBoolean = true
]

{ #category : #api }
RMDValidatedTextInputPresenter >> lastValidText [
	^ lastValidText
]

{ #category : #api }
RMDValidatedTextInputPresenter >> text: aStringOrText [
	(validation notNil and: [ (validation cull: aStringOrText) ~= true ])
		ifTrue: [ self beInvalid.
			^ nil ].
	self beOk.
	lastValidText := aStringOrText.
	^ super text: aStringOrText
]

{ #category : #api }
RMDValidatedTextInputPresenter >> validation [
	^ validation
]

{ #category : #api }
RMDValidatedTextInputPresenter >> validation: aBlock [
	validation := aBlock
]

{ #category : #'api-events' }
RMDValidatedTextInputPresenter >> whenLastValidTextChangedDo: aBlock [
	self property: #lastValidText whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDValidatedTextInputPresenter >> whenValidationChangedDo: aBlock [
	self property: #validation whenChangedDo: aBlock
]
