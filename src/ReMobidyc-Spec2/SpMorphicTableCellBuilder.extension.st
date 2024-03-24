Extension { #name : #SpMorphicTableCellBuilder }

{ #category : #'*ReMobidyc-Spec2' }
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

{ #category : #'*ReMobidyc-Spec2' }
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
