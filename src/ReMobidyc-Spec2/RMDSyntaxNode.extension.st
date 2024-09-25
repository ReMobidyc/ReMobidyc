Extension { #name : 'RMDSyntaxNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDSyntaxNode >> openPrettyPrint [

	| c |
	c := RSCanvas new.
	c addShape: self asPrettyPrintNode.
	c @ RSCanvasController.
	c open
]

{ #category : '*ReMobidyc-Spec2' }
RMDSyntaxNode >> openPrettyPrint: aString [

	| c |
	c := RSCanvas new.
	c addShape: self asPrettyPrintNode.
	c @ RSCanvasController.
	c openWithTitle: aString
]
