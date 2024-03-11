Class {
	#name : #RMDTraceableActionContextPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'subjectField',
		'verbField',
		'objectField',
		'directiveField',
		'attributeDefinitionTable',
		'attributeReferenceTable',
		'utilityDefinitionTable',
		'guardField',
		'context'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDTraceableActionContextPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
]

{ #category : #accessing }
RMDTraceableActionContextPresenter >> context: aRMDActionContext [

	context := aRMDActionContext.
	self contextChanged
]

{ #category : #updating }
RMDTraceableActionContextPresenter >> contextChanged [

	context
		ifNotNil: [
			| action guard |
			action := context action.
			subjectField text: context subjectDefinition name , '('
				, context subject printString , ')'.
			verbField text: action identifier.
			objectField text: (context hasObject
					 ifTrue: [
						 context objectDefinition name , '('
						 , context object printString , ')' ]
					 ifFalse: [ '' ]).
			guard := true.
			guardField text: (action guard
					 ifNotNil: [ :node |
						 guard := node value.
						 node printCondition , ' = ' , node printValue ]
					 ifNil: [ '' ]).
			guard
				ifTrue: [
					directiveField text: (',' join: action lifeDirectives).
					attributeDefinitionTable items: action attributeDefinitions ]
				ifFalse: [
					directiveField text: ''.
					attributeDefinitionTable items: #(  ) ].
			attributeReferenceTable items: action traceReferences ]
		ifNil: [
			subjectField text: ''.
			verbField text: ''.
			objectField text: ''.
			guardField text: ''.
			directiveField text: ''.
			attributeDefinitionTable items: #(  ).
			attributeReferenceTable items: #(  ) ].
	self layout: self layout
]

{ #category : #initialization }
RMDTraceableActionContextPresenter >> initializePresenters [

	super initializePresenters.
	subjectField := self newTextInput beNotEditable.
	verbField := self newTextInput beNotEditable.
	objectField := self newTextInput beNotEditable.
	guardField := self newTextInput beNotEditable.
	directiveField := self newTextInput beNotEditable.
	attributeDefinitionTable := self newTableWithHorizontalScrollbar
		                            enableHorizontalScrollbar;
		                            beResizable;
		                            addColumn:
			                            (SpStringTableColumn evaluated: [ :node |
					                             node variable printString , '''' ]);
		                            addColumn:
			                            (SpStringTableColumn evaluated: [ :node |
					                             '= '
					                             ,
						                             node definitionBody printExpression ]);
		                            addColumn:
			                            (SpStringTableColumn evaluated: [ :node |
					                             '= '
					                             , node definitionBody printValue ]);
		                            hideColumnHeaders;
		                            yourself.
	attributeReferenceTable := self newTableWithHorizontalScrollbar
		                           enableHorizontalScrollbar;
		                           beResizable;
		                           addColumn:
			                           (SpStringTableColumn evaluated: [ :node |
					                            node printExpression ]);
		                           addColumn:
			                           (SpStringTableColumn evaluated: [ :node |
					                            '= ' , node printValue ]);
		                           hideColumnHeaders;
		                           yourself
]

{ #category : #accessing }
RMDTraceableActionContextPresenter >> layout [

	| box |
	box := SpBoxLayout newVertical.
	context ifNotNil: [
		| action guard |
		box
			add: (SpBoxLayout newHorizontal
					 add: #subjectField;
					 add: #verbField;
					 add: #objectField)
			expand: false.
		action := context action.
		guard := true.
		action guard ifNotNil: [
			guard := action guard value.
			box
				add: (SpBoxLayout newHorizontal
						 add: 'when ' expand: false;
						 add: #guardField)
				expand: false ].
		guard ifTrue: [
			action lifeDirectives ifNotEmpty: [
				box
					add: (SpBoxLayout newHorizontal
							 add: 'with ' expand: false;
							 add: #directiveField)
					expand: false ].
			action attributeDefinitions ifNotEmpty: [
				box
					add: '' asPresenter expand: false;
					add: #attributeDefinitionTable ] ].
		attributeReferenceTable items ifNotEmpty: [
			box
				add: 'where' expand: false;
				add: #attributeReferenceTable ] ].
	^ box
]
