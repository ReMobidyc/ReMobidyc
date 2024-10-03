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

{ #category : 'operations' }
RMDAgentInitializerPresenter >> addAttributeInitializer [

	self newMenu
		addGroup: [ :group |
			self uninitializedAttributes do: [ :identifier |
					group addItem: [ :item |
							item
								name: identifier;
								action: [ self addAttributeInitializer: identifier ] ] ] ];
		openWithSpecAtPointer
]

{ #category : 'operations' }
RMDAgentInitializerPresenter >> addAttributeInitializer: aString [

	node ifNotNil: [
		node attributeInitializers: (node attributeInitializers copyWith:
				 ((self agentDefinition ifNotNil: [ :agentDef |
					   (agentDef attributeDeclarationAt: aString ifAbsent: [ nil ])
						   ifNotNil: #asAttributeInitializerNode ]) ifNil: [
					  RMDAttributeInitializerNode
						  identifier: aString
						  expression: '0' asRMDExpression ])).
		self owner ifNotNil: #nodeChanged ifNil: [ self nodeChanged ] ]
]

{ #category : 'accessing' }
RMDAgentInitializerPresenter >> agentDefinition [

	^ self subclassResponsibility
]

{ #category : 'layouting' }
RMDAgentInitializerPresenter >> attributesAndUtilitiesToNewLayout: newLayout [

	node ifNotNil: [
		node complementUtilityDefinitions.
		node attributeInitializers do: [ :initializer |
			newLayout
				add: (SpBoxLayout newHorizontal
						 add: (self newButton
								  icon: self removeIcon;
								  action: [
									  self removeAttributeInitializer: initializer identifier ])
						 width: self class buttonHeight;
						 add: (initializer asPresenter
								  whenExpressionSubmitDo: [ :txt | self updateLayout ];
								  disableIdentifier;
								  yourself);
						 yourself)
				height: self class buttonHeight;
				yourself ].
		node utilityDefinitions ifNotEmpty: [ :utils |
			newLayout add: 'where' expand: false.
			utils do: [ :util |
				newLayout
					add: (util asPresenter
							 whenExpressionSubmitDo: [ :txt | self updateLayout ];
							 disableIdentifier;
							 yourself)
					height: self class buttonHeight ] ] ].
	self uninitializedAttributes ifNotEmpty: [
		newLayout add: (SpBoxLayout newHorizontal
				 add: (self newButton
						  icon: self addIcon;
						  action: [ self addAttributeInitializer ];
						  yourself)
				 width: self class buttonHeight;
				 yourself) ].
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

{ #category : 'operations' }
RMDAgentInitializerPresenter >> removeAttributeInitializer: aString [

	node ifNotNil: [
		node attributeInitializers:
			(node attributeInitializers reject: [ :initializer |
				 initializer identifier = aString ]).
		self owner ifNotNil: #nodeChanged ifNil: [ self nodeChanged ] ]
]

{ #category : 'accessing' }
RMDAgentInitializerPresenter >> simulationModel: aRMDSimulationModel [

	super simulationModel: aRMDSimulationModel.
	self updateLayout
]

{ #category : 'accessing' }
RMDAgentInitializerPresenter >> uninitializedAttributes [

	^ self agentDefinition ifNil: [ #(  ) ] ifNotNil: [ :agentDef |
		  (agentDef allAttributeDeclarations collect: #identifier)
			  copyWithoutAll: (node attributeInitializers collect: #identifier) ]
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
