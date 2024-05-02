Extension { #name : 'SpMorphicTableCellBuilder' }

{ #category : '*ReMobidyc-Spec2' }
SpMorphicTableCellBuilder >> visitRMDPossessionalAgentDropListColumn: aDropListTableColumn [

	| presenter morph |
	presenter := SpDropListPresenter new
		             addStyle: 'table';
		             items: (aDropListTableColumn readObject: self item);
		             yourself.

	(aDropListTableColumn initialSelection: self item)
		ifNotNil: [ :selection | presenter selectItem: selection ]
		ifNil: [ presenter selectIndex: 1 ].
	aDropListTableColumn display ifNotNil: [
		presenter display: aDropListTableColumn display ].
	aDropListTableColumn selectedItemChangedAction ifNotNil: [
		presenter selection whenChangedDo: [ :selection |
			aDropListTableColumn selectedItemChangedAction
				cull: self item
				cull: (selection ifNotNil: [ presenter selectedItem ]) ] ].

	morph := presenter build.
	presenter adapter applyStyle: morph.

	self addCellMorph: morph column: aDropListTableColumn
]

{ #category : '*ReMobidyc-Spec2' }
SpMorphicTableCellBuilder >> visitRMDSyntaxColumn: aTableColumn [

	| content item |
	item := self item.

	content := aTableColumn readObject: item.
	"add properties"
	content := self
		           addAlignmentColumn: aTableColumn
		           item: item
		           to: content.
	content := self addColorColumn: aTableColumn item: item to: content.
	content := self addItalicColumn: aTableColumn item: item to: content.
	content := self addBoldColumn: aTableColumn item: item to: content.
	content := self
		           addUnderlineColumn: aTableColumn
		           item: item
		           to: content.

	aTableColumn isEditable
		ifTrue: [
		self visitRMDSyntaxColumnEditable: aTableColumn on: content ]
		ifFalse: [ "add cell"
			self addCell: content column: aTableColumn.
			"add background (this is a special case of properties, 
			since background needs to be applied to the cell and not to the text)"
			self
				addBackgroundColorColumn: aTableColumn
				item: item
				toMorph: cell ]
]

{ #category : '*ReMobidyc-Spec2' }
SpMorphicTableCellBuilder >> visitRMDSyntaxColumnEditable: aTableColumn on: content [

	| presenter morph |
	presenter := self dataSource model newTextInput
		             addStyle: 'compact';
		             text: content;
		             yourself.

	"add cell"
	morph := presenter build.
	aTableColumn textChangedAction ifNotNil: [ :action |
		presenter whenTextChangedDo: [ :text |
			action cull: self item cull: text cull: morph ] ].
	aTableColumn acceptAction ifNotNil: [ :action |
		presenter whenSubmitDo: [ :text | action cull: self item cull: text ].
		morph announcer
			when: MorphLostFocus
			do: [ action cull: self item cull: morph text ]
			for: self ].
	presenter adapter applyStyle.
	self addCellMorph: morph column: aTableColumn
]

{ #category : '*ReMobidyc-Spec2' }
SpMorphicTableCellBuilder >> visitRMDVariableOperatorDropListColumn: aDropListTableColumn [

	| presenter morph |
	presenter := SpDropListPresenter new
		             addStyle: 'table';
		             items: (aDropListTableColumn readObject: self item);
		             yourself.

	(aDropListTableColumn initialSelection: self item)
		ifNotNil: [ :selection | presenter selectItem: selection ]
		ifNil: [ presenter selectIndex: 1 ].
	aDropListTableColumn display ifNotNil: [
		presenter display: aDropListTableColumn display ].
	aDropListTableColumn selectedItemChangedAction ifNotNil: [
		presenter selection whenChangedDo: [ :selection |
			aDropListTableColumn selectedItemChangedAction
				cull: self item
				cull: (selection ifNotNil: [ presenter selectedItem ]) ] ].

	morph := presenter build.
	presenter adapter applyStyle: morph.

	self addCellMorph: morph column: aDropListTableColumn
]
