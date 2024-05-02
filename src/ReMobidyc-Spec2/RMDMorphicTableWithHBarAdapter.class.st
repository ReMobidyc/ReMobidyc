Class {
	#name : 'RMDMorphicTableWithHBarAdapter',
	#superclass : 'SpMorphicTableAdapter',
	#category : 'ReMobidyc-Spec2-Widgets',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Widgets'
}

{ #category : 'factory' }
RMDMorphicTableWithHBarAdapter >> buildWidget [

	widget := (self hasHorizontalScrollbar
		           ifTrue: [ SpFTTableMorph newWithHorizontalScrollBar ]
		           ifFalse: [ SpFTTableMorph new ])
		          hResizing: #spaceFill;
		          vResizing: #spaceFill;
		          intercellSpacing: self class intercellSpacing;
		          dragEnabled: self dragEnabled;
		          dropEnabled: self dropEnabled;
		          yourself.

	self addModelTo: widget.

	^ widget
]

{ #category : 'testing' }
RMDMorphicTableWithHBarAdapter >> hasHorizontalScrollbar [

	^ self model ifNotNil: #hasHorizontalScrollbar ifNil: [ false ]
]
