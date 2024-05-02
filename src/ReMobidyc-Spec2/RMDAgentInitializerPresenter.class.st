Class {
	#name : 'RMDAgentInitializerPresenter',
	#superclass : 'RMDSyntaxNodePresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'specs' }
RMDAgentInitializerPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 0;
		spacing: 0;
		yourself
]

{ #category : 'testing' }
RMDAgentInitializerPresenter class >> isAbstract [

	^ self == RMDAgentInitializerPresenter
]

{ #category : 'layouting' }
RMDAgentInitializerPresenter >> attributesAndUtilitiesToNewLayout: newLayout [

	node ifNotNil: [ 
		node complementUtilityDefinitions.
		node attributeInitializers do: [ :initializer | 
			newLayout
				add: (initializer asPresenter
						 whenExpressionSubmitDo: [ :txt | self updateLayout ];
						 disableIdentifier;
						 yourself)
				height: self class buttonHeight ].
		node utilityDefinitions ifNotEmpty: [ :utils | 
			newLayout add: 'where' expand: false.
			utils do: [ :util | 
				newLayout
					add: (util asPresenter
							 whenExpressionSubmitDo: [ :txt | self updateLayout ];
							 disableIdentifier;
							 yourself)
					height: self class buttonHeight ] ] ].
	^ newLayout
]

{ #category : 'initialization' }
RMDAgentInitializerPresenter >> initializePresenters [

	super initializePresenters.
	self whenBuiltDo: [
		self withAdapterDo: [ :a |
			a widgetDo: [ :w |
				w
					color: Color white;
					borderColor: Color darkGray;
					borderWidth: 1 ] ].
		self updateLayout ]
]

{ #category : 'layouting' }
RMDAgentInitializerPresenter >> newLayout [

	^ self subclassResponsibility
]

{ #category : 'updating' }
RMDAgentInitializerPresenter >> nodeChanged [
	self updateLayout
]

{ #category : 'updating' }
RMDAgentInitializerPresenter >> updateLayout [

	self layout: self newLayout".
	self withWidgetDo: [ :w | 
		w
			update: #color: with: { Color white };
			update: #borderColor: with: { Color darkGray };
			update: #borderWidth: with: { 1 } ]"
]
