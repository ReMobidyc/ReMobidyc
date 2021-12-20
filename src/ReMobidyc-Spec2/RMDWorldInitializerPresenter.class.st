Class {
	#name : #RMDWorldInitializerPresenter,
	#superclass : #RMDSpeciesInitializerPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDWorldInitializerPresenter class >> defaultSpec [
	<spec>
	^ super defaultSpec
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
				              add: 'World with' expand: false;
				              yourself)
		             height: self class inputTextHeight;
		             yourself.

	node ifNotNil: [ 
		node propertyInitializers do: [ :initializer | 
			newLayout
				add: (initializer asPresenter
						 disableIdentifier;
						 yourself)
				expand: false ] ].
	^ newLayout
]

{ #category : #accessing }
RMDWorldInitializerPresenter >> preferredHeight [
	^ (node propertyInitializers size + 1) * self class inputTextHeight
]
