Class {
	#name : #RMDSpeciesInitializerEditor,
	#superclass : #RMDSyntaxNodeEditor,
	#category : #'ReMobidyc-Spec2'
}

{ #category : #initialization }
RMDSpeciesInitializerEditor >> initializeWidgets [
	self whenBuiltDo: [ self updatePropertyInitializersList ]
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
