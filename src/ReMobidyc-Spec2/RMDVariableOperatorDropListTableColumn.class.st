Class {
	#name : 'RMDVariableOperatorDropListTableColumn',
	#superclass : 'SpDropListTableColumn',
	#instVars : [
		'initialSelectionBlock'
	],
	#category : 'ReMobidyc-Spec2-Columns',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Columns'
}

{ #category : 'examples' }
RMDVariableOperatorDropListTableColumn class >> example [

	^ SpTablePresenter new
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn:
			((SpDropListTableColumn title: 'Value' evaluated: [ {true . false} ])
				width: 50;
				yourself);
		items: self class environment allClasses;
		beResizable;
		open
]

{ #category : 'visiting' }
RMDVariableOperatorDropListTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitRMDVariableOperatorDropListColumn: self
]

{ #category : 'defaults' }
RMDVariableOperatorDropListTableColumn >> defaultDisplay [

	^ [ :operator | operator ]
]

{ #category : 'defaults' }
RMDVariableOperatorDropListTableColumn >> defaultEvaluation [

	^ [ self possibleOperators ]
]

{ #category : 'defaults' }
RMDVariableOperatorDropListTableColumn >> defaultInitialSelectionBlock [

	^ [ :attributeDefinition | attributeDefinition variableOperator ]
]

{ #category : 'defaults' }
RMDVariableOperatorDropListTableColumn >> defaultSelectedItemChangedAction [

	^ [ :attributeDefinition :operator |
	  attributeDefinition variableOperator: operator ]
]

{ #category : 'defaults' }
RMDVariableOperatorDropListTableColumn >> defaultStartWithSelection [

	^ true
]

{ #category : 'defaults' }
RMDVariableOperatorDropListTableColumn >> defaultWidth [

	^ 50
]

{ #category : 'accessing' }
RMDVariableOperatorDropListTableColumn >> initialSelection: aRMDAttributeDefinitionNode [

	^ initialSelectionBlock ifNotNil: [
		  initialSelectionBlock cull: aRMDAttributeDefinitionNode ]
]

{ #category : 'accessing' }
RMDVariableOperatorDropListTableColumn >> initialSelectionBlock [

	^ initialSelectionBlock
]

{ #category : 'accessing' }
RMDVariableOperatorDropListTableColumn >> initialSelectionBlock: aBlock [

	initialSelectionBlock := aBlock
]

{ #category : 'initialization' }
RMDVariableOperatorDropListTableColumn >> initialize [

	super initialize.
	evaluation := self defaultEvaluation.
	display := self defaultDisplay.
	self startWithSelection: self defaultInitialSelectionBlock.
	selectedItemChangedAction := self defaultSelectedItemChangedAction.
	self width: self defaultWidth
]

{ #category : 'accessing' }
RMDVariableOperatorDropListTableColumn >> possibleOperators [

	^ {
		  ''.
		  RMDAbstractAssignableAttributeVariableNode deltaOperator.
		  RMDAbstractAssignableAttributeVariableNode differentialOperator }
]

{ #category : 'accessing' }
RMDVariableOperatorDropListTableColumn >> startWithSelection [

	initialSelectionBlock ifNil: [
		initialSelectionBlock := self defaultInitialSelectionBlock ].
	super startWithSelection
]

{ #category : 'accessing' }
RMDVariableOperatorDropListTableColumn >> startWithSelection: aBlock [

	initialSelectionBlock ifNil: [ initialSelectionBlock := aBlock ].
	super startWithSelection
]

{ #category : 'accessing' }
RMDVariableOperatorDropListTableColumn >> startWithoutSelection [

	initialSelectionBlock := nil.
	super startWithoutSelection
]
