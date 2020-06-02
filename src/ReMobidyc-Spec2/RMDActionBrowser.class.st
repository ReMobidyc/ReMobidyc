Class {
	#name : #RMDActionBrowser,
	#superclass : #RMDAbstractDefinitionBrowser,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #examples }
RMDActionBrowser class >> example1 [
	RMDActionBrowser new
		interpreter: RMDInterpreter sugarScape;
		openWithSpec
]

{ #category : #accessing }
RMDActionBrowser >> getListSelector [
	^ #actionNames
]

{ #category : #accessing }
RMDActionBrowser >> getSource: aString ifAbsent: aBlock [
	^ interpreter actionDefinitionAt: aString ifAbsent: aBlock
]

{ #category : #accessing }
RMDActionBrowser >> parser [
	^ RMDGrammar new actionDefinition
]
