Class {
	#name : #RMDWorldInitializerEditor,
	#superclass : #RMDSpeciesInitializerEditor,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDWorldInitializerEditor class >> defaultSpec [
	<spec>
	^ super defaultSpec
		add: 'World with' expand: false;
		yourself
]

{ #category : #accessing }
RMDWorldInitializerEditor >> preferredHeight [
	^ (node propertyInitializers size + 1) * self class inputTextHeight
]
