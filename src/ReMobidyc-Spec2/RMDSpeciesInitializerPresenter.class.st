Class {
	#name : #RMDSpeciesInitializerPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDSpeciesInitializerPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 0;
		spacing: 0;
		yourself
]

{ #category : #initialization }
RMDSpeciesInitializerPresenter >> initializePresenters [
	super initializePresenters.
	self
		whenBuiltDo: [ self
				withWidgetDo: [ :w | 
					w
						update: #color: with: {Color white};
						update: #borderColor: with: {Color darkGray};
						update: #borderWidth: with: {1} ].
			self updateAttributeInitializersList ]
]

{ #category : #layouting }
RMDSpeciesInitializerPresenter >> newLayout [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDSpeciesInitializerPresenter >> nodeChanged [
	self updateAttributeInitializersList
]

{ #category : #updating }
RMDSpeciesInitializerPresenter >> updateAttributeInitializersList [

	self layout: self newLayout
]
