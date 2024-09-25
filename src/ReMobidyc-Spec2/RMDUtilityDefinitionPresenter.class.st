Class {
	#name : 'RMDUtilityDefinitionPresenter',
	#superclass : 'RMDSyntaxNodePresenter',
	#instVars : [
		'identifierField',
		'expressionField'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'specs' }
RMDUtilityDefinitionPresenter class >> defaultLayout [

	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: '     ' expand: false;
				   add: #identifierField width: 100;
				   add: ' = ' expand: false;
				   add: #expressionField;
				   yourself)
		  height: self inputTextHeight
]

{ #category : 'menu' }
RMDUtilityDefinitionPresenter >> definitionBodyFieldMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'Templates...';
						  subMenu: expressionField templateMenu ] ];
		  yourself
]

{ #category : 'api' }
RMDUtilityDefinitionPresenter >> disableIdentifier [
	identifierField disable
]

{ #category : 'api' }
RMDUtilityDefinitionPresenter >> enableIdentifier [
	identifierField enable
]

{ #category : 'accessing' }
RMDUtilityDefinitionPresenter >> expressionField [
	^ expressionField
]

{ #category : 'api' }
RMDUtilityDefinitionPresenter >> identifierEnabled [
	^ identifierField enabled
]

{ #category : 'accessing' }
RMDUtilityDefinitionPresenter >> identifierField [
	^ identifierField
]

{ #category : 'initialization' }
RMDUtilityDefinitionPresenter >> initializePresenters [

	super initializePresenters.
	identifierField := self newSyntaxNodeTextInput
		                   beIdentifier;
		                   whenLastValidSyntaxNodeChangedDo: [ 
			                   node ifNotNil: [ 
					                   identifierField text asString trim 
						                   ifNotEmpty: [ :id | 
							                   node variable identifier: id ] ] ];
		                   yourself.
	expressionField := self newSyntaxNodeTextInput
		                   beExpression;
		                   allowEmpty;
		                   contextMenu: [ expressionField templateMenu ];
		                   whenSyntaxNodeChangedDo: [ :expr | 
			                   node ifNotNil: [ node definitionBody: expr ] ];
		                   yourself
]

{ #category : 'initialization' }
RMDUtilityDefinitionPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Utility definition'.
	aWindowPresenter initialExtent:
		600 @ (self preferredHeight + self class buttonHeight * 2)
]

{ #category : 'accessing' }
RMDUtilityDefinitionPresenter >> nodeChanged [
	self
		updateIdentifierField;
		updateExpressionField
]

{ #category : 'accessing' }
RMDUtilityDefinitionPresenter >> preferredHeight [
	^ self class inputTextHeight
]

{ #category : 'updating' }
RMDUtilityDefinitionPresenter >> updateExpressionField [

	expressionField syntaxNode: node definitionBody
]

{ #category : 'updating' }
RMDUtilityDefinitionPresenter >> updateIdentifierField [
	identifierField text: node variable identifier
]

{ #category : 'api-events' }
RMDUtilityDefinitionPresenter >> whenExpressionSubmitDo: aBlock [

	expressionField whenSubmitDo: aBlock
]

{ #category : 'api-events' }
RMDUtilityDefinitionPresenter >> whenIdentifierEnabledChangedDo: aBlock [
	identifierField whenEnabledChangedDo: aBlock
]
