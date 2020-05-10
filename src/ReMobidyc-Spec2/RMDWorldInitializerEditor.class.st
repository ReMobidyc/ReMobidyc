Class {
	#name : #RMDWorldInitializerEditor,
	#superclass : #RMDSpeciesInitializerEditor,
	#category : #'ReMobidyc-Spec2'
}

{ #category : #specs }
RMDWorldInitializerEditor class >> defaultSpec [
	<spec>
	^ super defaultSpec
		add: 'World with' expand: false;
		yourself
]
