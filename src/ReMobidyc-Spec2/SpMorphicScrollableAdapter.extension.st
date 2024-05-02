Extension { #name : 'SpMorphicScrollableAdapter' }

{ #category : '*ReMobidyc-Spec2' }
SpMorphicScrollableAdapter >> layout: aLayout [

	layout := aLayout.
	
	emptyLayoutMarker := PanelMorph new
		                     hResizing: #spaceFill;
		                     vResizing: #spaceFill;
		                     yourself.
	widget ifNil: [ 
		widget := GeneralScrollPaneMorph new
			          changeScrollerTableLayout;
			          hResizing: #spaceFill;
			          vResizing: #spaceFill;
			          color: Color transparent;
			          borderColor: Color transparent;
			          scrollTarget: emptyLayoutMarker;
			          yourself ].

	aLayout whenChildrenAddedDo: [ :ann | 
		self basicAdd: ann child constraints: (aLayout constraintsFor: ann child) to: widget ].

	aLayout whenChildrenRemovedDo: [ :ann | self removeChild: ann child ].

	super layout: aLayout
]
