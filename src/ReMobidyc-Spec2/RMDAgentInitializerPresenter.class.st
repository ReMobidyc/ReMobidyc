Class {
	#name : #RMDAgentInitializerPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAgentInitializerPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 0;
		spacing: 0;
		yourself
]

{ #category : #initialization }
RMDAgentInitializerPresenter >> initializePresenters [
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
RMDAgentInitializerPresenter >> newLayout [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAgentInitializerPresenter >> nodeChanged [
	self updateAttributeInitializersList
]

{ #category : #updating }
RMDAgentInitializerPresenter >> updateAttributeInitializersList [

	self layout: self newLayout
]
