Class {
	#name : 'RMDAttributeDeclarationPresenter',
	#superclass : 'RMDSyntaxNodePresenter',
	#instVars : [
		'identifierField',
		'unitField',
		'initializerExpressionField',
		'agentName',
		'utilities'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDAttributeDeclarationPresenter class >> defaultLayout [

	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: '     ' expand: false;
				   add: #identifierField width: 180;
				   add: ' [' expand: false;
				   add: #unitField width: 50;
				   add: '] = ' expand: false;
				   add: #initializerExpressionField expand: true;
				   yourself)
		  height: self inputTextHeight
]

{ #category : 'accessing' }
RMDAttributeDeclarationPresenter >> agentName [

	^ agentName
]

{ #category : 'accessing' }
RMDAttributeDeclarationPresenter >> agentName: aString [

	agentName := aString.
	initializerExpressionField subjectBlock: [ agentName ]
]

{ #category : 'initialization' }
RMDAttributeDeclarationPresenter >> initializePresenters [

	super initializePresenters.
	identifierField := self newTextInput
		                   beText;
		                   placeholder: 'identifier';
		                   whenTextChangedDo: [
			                   node ifNotNil: [
					                   node identifier:
							                   identifierField text asString trim ] ];
		                   yourself.
	unitField := self newValidatedTextInput
		             placeholder: 'unit';
		             validation: [ :text |
			             (RMDGrammar current unit optional end parse:
					              text asString trim) isPetit2Failure not ];
		             contextMenu: [
			             | menu |
			             menu := self newMenu.
			             menu addItem: [ :item |
					             item
						             name: 'Template...';
						             subMenu: unitField unitTemplateMenu ] ];
		             whenLastValidTextChangedDo: [ :text |
			             node unit:
				             ((RMDGrammar current unit optional end parse:
					               text asString trim) ifNil: [ RMDUnit noDimension ]).
			             initializerExpressionField
				             expectedType: (RMDType unit: node unit);
				             prettyPrint ];
		             yourself.
	initializerExpressionField := self newHighlightingSyntaxNodeTextInput
		                              placeholder:
			                              'initial value (optional)';
		                              beExpression;
		                              allowEmpty;
		                              contextMenu: [
			                              | menu |
			                              menu := self newMenu.
			                              menu addItem: [ :item |
					                              item
						                              name: 'Template...';
						                              subMenu:
							                              initializerExpressionField
								                              templateMenu ] ];
		                              whenSyntaxNodeChangedDo: [
		                              :newExpression |
		                              node initializerExpression:
			                              newExpression ];
		                              yourself.
	self focusOrder: {
			identifierField.
			unitField.
			initializerExpressionField } asOrderedCollection
]

{ #category : 'initialization' }
RMDAttributeDeclarationPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 600 @ (self class buttonHeight * 3.5)
]

{ #category : 'updating' }
RMDAttributeDeclarationPresenter >> nodeChanged [

	self
		updateIdentifier;
		updateUnit;
		updateInitializerExpressionField
]

{ #category : 'accessing' }
RMDAttributeDeclarationPresenter >> preferredHeight [

	^ self class inputTextHeight
]

{ #category : 'accessing' }
RMDAttributeDeclarationPresenter >> simulationModel: aRMDSimulationModel [

	super simulationModel: aRMDSimulationModel.
	initializerExpressionField simulationModelBlock: [ simulationModel ]
]

{ #category : 'updating' }
RMDAttributeDeclarationPresenter >> updateIdentifier [
	node ifNotNil: [ identifierField text: node identifier ]
]

{ #category : 'updating' }
RMDAttributeDeclarationPresenter >> updateInitializerExpressionField [

	node ifNotNil: [ 
		initializerExpressionField syntaxNode: node initializerExpression ]
]

{ #category : 'updating' }
RMDAttributeDeclarationPresenter >> updateUnit [
	node
		ifNotNil: [ | unit |
			unit := node unit.
			unitField
				text:
					(unit hasDimension
						ifTrue: [ unit printString ]
						ifFalse: [ '' ]) ]
]

{ #category : 'accessing' }
RMDAttributeDeclarationPresenter >> utilities: anArrayOfRMDUtilityDefinitionNode [

	utilities := anArrayOfRMDUtilityDefinitionNode.
	initializerExpressionField utilitiesBlock: [ utilities ]
]

{ #category : 'enumerating' }
RMDAttributeDeclarationPresenter >> whenInitializerExpressionSubmitDo: aBlock [

	initializerExpressionField whenSubmitDo: aBlock
]
