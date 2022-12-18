Class {
	#name : #RMDRubSourceMode,
	#superclass : #RubPlainTextMode,
	#category : #'ReMobidyc-Spec2-Utilities'
}

{ #category : #shout }
RMDRubSourceMode >> shoutAboutToStyle: aRubShoutStylerDecorator [

	^ true
]

{ #category : #shout }
RMDRubSourceMode >> updateStyler [

	
]

{ #category : #shout }
RMDRubSourceMode >> withShoutStyler [
	self textArea withDecoratorNamed: #shoutStyler.
	self updateStyler.
]

{ #category : #shout }
RMDRubSourceMode >> withoutShoutStyler [
	self textArea withoutDecoratorNamed: #shoutStyler
]
