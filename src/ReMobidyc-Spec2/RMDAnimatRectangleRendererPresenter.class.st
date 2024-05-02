Class {
	#name : 'RMDAnimatRectangleRendererPresenter',
	#superclass : 'RMDAnimatShapeRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'specs' }
RMDAnimatRectangleRendererPresenter class >> defaultLayout [

	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: #animatLabel expand: false;
				   add: #colorDropList width: 60;
				   add: ' rectangle of ' expand: false;
				   add: #shapeSizeField width: 40;
				   add: ' pixels' expand: false;
				   yourself)
		  height: self inputTextHeight
]
