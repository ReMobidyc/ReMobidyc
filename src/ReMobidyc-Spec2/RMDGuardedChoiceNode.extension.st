Extension { #name : #RMDGuardedChoiceNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDGuardedChoiceNode >> asPrettyPrintNode [

	| choices rect |
	choices := guardsAndChoices collect: [ :assoc |
		           assoc key = true
			           ifTrue: [ assoc value asPrettyPrintNode ]
			           ifFalse: [
				           | guard expr if comma |
				           guard := assoc key asPrettyPrintNode.
				           expr := assoc value asPrettyPrintNode.
				           if := RMDPrettyPrintText keyword: 'if'.
				           comma := RMDPrettyPrintText operator: ','.
				           expr , if , guard , comma.
				           RMDPrettyPrintNode
					           with: expr
					           with: if
					           with: guard
					           with: comma ] ].
	RSVerticalLineLayout on: choices.
	choices := RSComposite new shapes: choices.
	rect := choices encompassingRectangle.
	^ RMDPrettyPrintNode withAll: {
			  (RSLine new
				   color: #gray;
				   startPoint: rect topLeft - (4 @ 4);
				   endPoint: rect topLeft - (8 @ 4)).
			  (RSLine new
				   color: #gray;
				   startPoint: rect bottomLeft - (4 @ -4);
				   endPoint: rect bottomLeft - (8 @ -4)).
			  (RSLine new
				   color: #gray;
				   startPoint: rect topLeft - (8 @ 4);
				   endPoint: rect bottomLeft - (8 @ -4)).
			  choices }
]
