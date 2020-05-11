Class {
	#name : #RMDPresenter,
	#superclass : #SpPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #widgets }
RMDPresenter >> newColor [
	^ self
		newColor:
			{Color white.
			Color gray.
			Color black} , (Color wheel: 7)
]

{ #category : #widgets }
RMDPresenter >> newColor: anArrayOfColor [
	^ self newDropList
		items: anArrayOfColor;
		iconBlock: [ :c | 
			| form |
			form := Form extent: self class inputTextHeight asPoint depth: 32.
			form getCanvas fillColor: c.
			form ];
		display: [ :item | '' ];
		yourself
]

{ #category : #widgets }
RMDPresenter >> newExpressionTextInput [
	^ self instantiate: RMDExpressionTextInputPresenter
]

{ #category : #widgets }
RMDPresenter >> newNumberInput [
	^ self instantiate: RMDNumberInputPresenter
]

{ #category : #widgets }
RMDPresenter >> newValidatedTextInput [
	^ self instantiate: RMDValidatedTextInputPresenter
]
