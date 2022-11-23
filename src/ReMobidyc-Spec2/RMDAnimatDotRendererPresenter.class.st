Class {
	#name : #RMDAnimatDotRendererPresenter,
	#superclass : #RMDAnimatShapeRendererPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDAnimatDotRendererPresenter class >> defaultLayout [

	<spec>
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   borderWidth: 5;
				   spacing: 5;
				   add: #animatLabel expand: false;
				   add: #colorDropList width: 60;
				   add: ' dot of ' expand: false;
				   add: #shapeSizeField width: 40;
				   add: ' pixels' expand: false;
				   yourself)
		  height: self inputTextHeight
]
