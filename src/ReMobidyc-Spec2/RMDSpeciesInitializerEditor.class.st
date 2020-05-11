Class {
	#name : #RMDSpeciesInitializerEditor,
	#superclass : #RMDSyntaxNodeEditor,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDSpeciesInitializerEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 10;
		spacing: 10;
		yourself
]

{ #category : #initialization }
RMDSpeciesInitializerEditor >> initializeWidgets [
	self
		whenBuiltDo: [ self
				withWidgetDo: [ :w | 
					w
						update: #color: with: {Color white};
						update: #borderColor: with: {Color lightGray};
						update: #borderWidth: with: {1} ].
			self updatePropertyInitializersList ]
]

{ #category : #accessing }
RMDSpeciesInitializerEditor >> nodeChanged [
	self updatePropertyInitializersList
]

{ #category : #updating }
RMDSpeciesInitializerEditor >> updatePropertyInitializersList [
	layout
		ifNotNil: [ (layout presenters
				select: [ :presenter | presenter isKindOf: RMDPropertyInitializerEditor ])
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
