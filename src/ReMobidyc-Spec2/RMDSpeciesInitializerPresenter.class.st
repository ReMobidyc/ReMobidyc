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
			self updatePropertyInitializersList ]
]

{ #category : #accessing }
RMDSpeciesInitializerPresenter >> nodeChanged [
	self updatePropertyInitializersList
]

{ #category : #updating }
RMDSpeciesInitializerPresenter >> updatePropertyInitializersList [
	layout
		ifNotNil: [ (layout presenters
				select: [ :presenter | presenter isKindOf: RMDPropertyInitializerPresenter ])
				do: [ :presenter | layout remove: presenter ].
			node
				ifNotNil: [ node propertyInitializers
						do: [ :initializer | 
							layout
								add:
									(initializer asPresenter
										disableIdentifier;
										yourself)
								expand: false ] ] ]
]
