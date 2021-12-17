Extension { #name : #SpMorphicScrollableAdapter }

{ #category : #'*ReMobidyc-Spec2' }
SpMorphicScrollableAdapter >> layout: aLayout [

	emptyLayoutMarker := PanelMorph new
		                     hResizing: #spaceFill;
		                     vResizing: #spaceFill;
		                     yourself.
	widget ifNil: [ 
		widget := GeneralScrollPane new
			          changeScrollerTableLayout;
			          hResizing: #spaceFill;
			          vResizing: #spaceFill;
			          color: Color transparent;
			          borderColor: Color transparent;
			          scrollTarget: emptyLayoutMarker;
			          yourself ].

	aLayout child ifNotNil: [ 
		self
			basicAdd: (model perform: aLayout child)
			constraints: (aLayout constraintsFor: aLayout child)
			to: widget ].

	aLayout whenChildrenAddedDo: [ :ann | 
		self
			basicAdd: ann child
			constraints: (aLayout constraintsFor: ann child)
			to: widget ].

	aLayout whenChildrenRemovedDo: [ :ann | self removeChild: ann child ].

	super layout: aLayout
]
