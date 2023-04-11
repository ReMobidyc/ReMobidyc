Class {
	#name : #RMDWorldInitializerPresenter,
	#superclass : #RMDAgentInitializerPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDWorldInitializerPresenter class >> defaultLayout [
	<spec>
	^ super defaultLayout
		add: 'World with' expand: false;
		yourself
]

{ #category : #layouting }
RMDWorldInitializerPresenter >> newLayout [

	| newLayout |
	newLayout := SpBoxLayout newVertical
		             borderWidth: 0;
		             spacing: 0;
		             add: (SpBoxLayout newHorizontal
				              vAlignCenter;
				              add: 'World with' expand: false;
				              yourself)
		             height: self class inputTextHeight;
		             yourself.

	self attributesAndUtilitiesToNewLayout: newLayout.
	^ newLayout
]

{ #category : #accessing }
RMDWorldInitializerPresenter >> preferredHeight [
	^ (node attributeInitializers size + 1) * self class inputTextHeight
]
