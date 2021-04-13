Class {
	#name : #RMDPresenter,
	#superclass : #SpPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#category : #'ReMobidyc-Spec2-Abstract'
}

{ #category : #icons }
RMDPresenter >> addIcon [
	^ Smalltalk ui icons iconNamed: #smallAdd
]

{ #category : #icons }
RMDPresenter >> editIcon [
	^ Smalltalk ui icons iconNamed: #smallConfiguration
]

{ #category : #initialization }
RMDPresenter >> initializePresenters [
	self
		whenBuiltDo: [ :w | 
			| font |
			font := TextStyle defaultFont.
			w widget
				allMorphsDo: [ :m | 
					(m respondsTo: #font:)
						ifTrue: [ m font: font ] ] ]
]

{ #category : #widgets }
RMDPresenter >> newAnimatInput [
	^ self newValidatedTextInput
		validation: [ :name | 
			(self speciesValidation value: name)
				and: [ (#('World' 'Cell') includes: name asString) not ] ]
]

{ #category : #widgets }
RMDPresenter >> newColorDropList [
	^ self
		newColorDropList:
			{Color black.
			Color gray} , (Color wheel: 5)
]

{ #category : #widgets }
RMDPresenter >> newColorDropList: anArrayOfColor [
	^ self newDropList
		items: anArrayOfColor;
		display: [ :color | '' ];
		iconBlock: [ :color | 
			| form |
			form := Form extent: 14 @ 14 depth: 32.
			form getCanvas fillColor: color.
			form ];
		yourself
]

{ #category : #widgets }
RMDPresenter >> newHighlightingSyntaxNodeTextInput [
	^ self instantiate: RMDHighlightingSyntaxNodeTextInputPresenter
]

{ #category : #widgets }
RMDPresenter >> newNumberInput [
	^ self instantiate: RMDNumberInputPresenter
]

{ #category : #widgets }
RMDPresenter >> newSourceWith: aPP2Node [
	^ (self instantiate: RMDSourceTextPresenter)
		parser: aPP2Node;
		yourself
]

{ #category : #widgets }
RMDPresenter >> newSyntaxNodeTextInput [
	^ self instantiate: RMDSyntaxNodeTextInputPresenter
]

{ #category : #widgets }
RMDPresenter >> newValidatedTextInput [
	^ self instantiate: RMDValidatedTextInputPresenter
]

{ #category : #icons }
RMDPresenter >> removeIcon [
	^ Smalltalk ui icons iconNamed: #smallDelete
]

{ #category : #icons }
RMDPresenter >> replacementIcon [
	^ Smalltalk ui icons iconNamed: #smallForward
]

{ #category : #private }
RMDPresenter >> speciesValidation [
	^ [ :name | name asString allSatisfy: [ :c | c isLetter or: [ c isDigit ] ] ]
]
