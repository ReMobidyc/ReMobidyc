Class {
	#name : #RMDTraceableActionPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'directiveField',
		'attributeDefinitionTable',
		'attributeReferenceTable',
		'utilityDefinitionTable',
		'guardField',
		'action'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDTraceableActionPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
]

{ #category : #accessing }
RMDTraceableActionPresenter >> action [

	^ action
]

{ #category : #accessing }
RMDTraceableActionPresenter >> action: aRMDActionNode [

	action := aRMDActionNode.
	self actionChanged
]

{ #category : #updating }
RMDTraceableActionPresenter >> actionChanged [

	action
		ifNotNil: [
			guardField text:
				(action guard ifNotNil: #printString ifNil: [ '' ]).
			directiveField text: (',' join: action lifeDirectives).
			attributeDefinitionTable items: action attributeDefinitions.
			attributeReferenceTable items: action traceReferences ]
		ifNil: [
			guardField text: ''.
			directiveField text: ''.
			attributeDefinitionTable items: #(  ).
			attributeReferenceTable items: #(  ) ].
	self layout: self layout
]

{ #category : #initialization }
RMDTraceableActionPresenter >> initializePresenters [

	super initializePresenters.
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
RMDTraceableActionPresenter >> layout [

	| box |
	box := SpBoxLayout newVertical.
	action ifNotNil: [
		action guard ifNotNil: [
			box
				add: (SpBoxLayout newHorizontal
						 add: 'when ' expand: false;
						 add: #guardField)
				expand: false ].
		action lifeDirectives ifNotEmpty: [
			box
				add: (SpBoxLayout newHorizontal
						 add: 'with ' expand: false;
						 add: #directiveField)
				expand: false ].
		action attributeDefinitions ifNotEmpty: [
			box
				add: '' asPresenter expand: false;
				add: #attributeDefinitionTable ].
		attributeReferenceTable items ifNotEmpty: [
			box
				add: 'where' expand: false;
				add: #attributeReferenceTable ] ].
	^ box
]
