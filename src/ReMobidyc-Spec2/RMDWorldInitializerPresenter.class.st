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

{ #category : #accessing }
RMDWorldInitializerPresenter >> preferredHeight [
	^ (node propertyInitializers size + 1) * self class inputTextHeight
]
