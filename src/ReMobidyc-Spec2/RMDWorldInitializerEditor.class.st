Class {
	#name : #RMDWorldInitializerEditor,
	#superclass : #RMDSpeciesInitializerEditor,
	#category : #'ReMobidyc-Spec2'
}

{ #category : #specs }
RMDWorldInitializerEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 10;
		spacing: 10;
		yourself
]
