Class {
	#name : #RMDAnimatBrowser,
	#superclass : #RMDAbstractDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #examples }
RMDAnimatBrowser class >> example1 [
	RMDAnimatBrowser new
		interpreter: RMDInterpreter sugarScape;
		openWithSpec
]

{ #category : #accessing }
RMDAnimatBrowser >> getListSelector [
	^ #animatNames
]

{ #category : #accessing }
RMDAnimatBrowser >> getSource: aString ifAbsent: aBlock [
	^ interpreter animatDefinitionAt: aString ifAbsent: aBlock
]

{ #category : #accessing }
RMDAnimatBrowser >> parser [
	^ RMDGrammar new animatDefinition end
]
