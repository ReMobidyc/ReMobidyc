Class {
	#name : #RMDPrettyPrintNode,
	#superclass : #RSComposite,
	#category : #'ReMobidyc-Spec2-PrettyPrint'
}

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> agent: aString attribute: anotherString [
	"RMDPrettyPrintNode agent: 'my' attribute: 'x'"

	| agent attribute |
	agent := RMDPrettyPrintText agent: aString.
	attribute := RMDPrettyPrintText identifier: anotherString.
	agent , attribute.
	^ self new shapes: {
			  agent.
			  attribute }
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> binaryOperator: aString arguments: aCollectionOfRMDPrettyPrintNode [

	^ self new shapes: ((Array streamContents: [ :stream |
				    aCollectionOfRMDPrettyPrintNode
					    do: [ :node | stream nextPut: node ]
					    separatedBy: [
						    stream nextPut: (RMDPrettyPrintText operator: aString) ] ])
			   reduce: [ :n1 :n2 | n1 , n2 ];
			   yourself)
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> directive: aString [

	^ self new
		  shapes: { (RMDPrettyPrintText keyword: aString) };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> directive: aString agent: anotherString [

	| directiveNode agentNode |
	directiveNode := RMDPrettyPrintText keyword: aString.
	agentNode := RMDPrettyPrintText agent: anotherString.
	directiveNode , agentNode.
	^ self new
		  shapes: {
				  directiveNode.
				  agentNode };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> directive: aString agent: anotherString keyword: suffixString [

	| directiveNode agentNode suffixNode |
	directiveNode := RMDPrettyPrintText keyword: aString.
	agentNode := RMDPrettyPrintText agent: anotherString.
	suffixNode := RMDPrettyPrintText keyword: suffixString.
	directiveNode , agentNode , suffixNode.
	^ self new
		  shapes: {
				  directiveNode.
				  agentNode.
				  suffixNode };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> directive: aString agent: anotherString keyword: infixString expression: aRMDPrettyPrintNode keyword: suffixString [

	| directiveNode agentNode infixNode suffixNode |
	directiveNode := RMDPrettyPrintText keyword: aString.
	agentNode := RMDPrettyPrintText agent: anotherString.
	infixNode := RMDPrettyPrintText keyword: infixString.
	suffixNode := RMDPrettyPrintText keyword: suffixString.
	directiveNode , agentNode , infixNode , aRMDPrettyPrintNode
	, suffixNode.
	^ self new
		  shapes: {
				  directiveNode.
				  agentNode.
				  infixNode.
				  aRMDPrettyPrintNode.
				  suffixNode };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> directive: aString attribute: anotherString [

	| directiveNode agentNode |
	directiveNode := RMDPrettyPrintText keyword: aString.
	agentNode := RMDPrettyPrintText identifier: anotherString.
	directiveNode , agentNode.
	^ self new
		  shapes: {
				  directiveNode.
				  agentNode };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> directive: aString node: aRMDPrettyPrintNode1 suffix: anotherString node: aRMDPrettyPrintNode2 [

	| directiveNode suffixNode |
	directiveNode := RMDPrettyPrintText keyword: aString.
	suffixNode := RMDPrettyPrintText keyword: anotherString.
	directiveNode , aRMDPrettyPrintNode1 , suffixNode
	, aRMDPrettyPrintNode2.
	^ self new
		  shapes: {
				  directiveNode.
				  aRMDPrettyPrintNode1.
				  suffixNode.
				  aRMDPrettyPrintNode2 };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> fraction: aRMDPrettyPrintNode over: anotherRMDPrettyPrintNode [

	| rect hline |
	aRMDPrettyPrintNode translateBottomMiddleTo: 0 @ self margin negated.
	anotherRMDPrettyPrintNode translateTopMiddleTo: 0 @ self margin.
	rect := aRMDPrettyPrintNode encompassingRectangle merge:
		        anotherRMDPrettyPrintNode encompassingRectangle.
	hline := RSLine new
		         startPoint: rect left - self margin @ 0;
		         endPoint: rect right + self margin @ 0;
		         width: 1;
		         color: Color black.
	^ self new
		  shapes: {
				  aRMDPrettyPrintNode.
				  hline.
				  anotherRMDPrettyPrintNode };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> function: aString arguments: anArrayOfRMDPrettyPrintNode [

	^ self new shapes: ((Array streamContents: [ :stream |
				    stream
					    nextPut: (RMDPrettyPrintText keyword: aString);
					    nextPut: (RMDPrettyPrintText operator: '(').
				    anArrayOfRMDPrettyPrintNode
					    do: [ :node | stream nextPut: node ]
					    separatedBy: [
					    stream nextPut: (RMDPrettyPrintText operator: ',') ].
				    stream nextPut: (RMDPrettyPrintText operator: ')') ])
			   reduce: [ :n1 :n2 | n1 , n2 ];
			   yourself)
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> literal: aString unit: anotherString [

	| literalNode unitNode |
	literalNode := RMDPrettyPrintText literal: aString.
	unitNode := RMDPrettyPrintText unit: anotherString.
	literalNode , unitNode.
	^ self new shapes: {
			  literalNode.
			  unitNode }
]

{ #category : #accessing }
RMDPrettyPrintNode class >> margin [

	^ 2
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> parenthesis: aRMDPrettyPrintNode [
	"RMDPrettyPrintNode agent: 'my' attribute: 'x'"

	| lparen rparen |
	lparen := RMDPrettyPrintText operator: '('.
	rparen := RMDPrettyPrintText operator: ')'.
	lparen , aRMDPrettyPrintNode , rparen.
	^ self new shapes: {
			  lparen.
			  aRMDPrettyPrintNode.
			  rparen }
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> utility: aString [

	| utility |
	utility := RMDPrettyPrintText identifier: aString.
	^ self new shapes: { utility }
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> with: aRMDPrettyPrintNode [

	^ self new
		  shapes: { aRMDPrettyPrintNode };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> with: aRMDPrettyPrintNode with: anotherRMDPrettyPrintNode [

	^ self new
		  shapes: {
				  aRMDPrettyPrintNode.
				  anotherRMDPrettyPrintNode };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> with: aRMDPrettyPrintNode1 with: aRMDPrettyPrintNode2 with: aRMDPrettyPrintNode3 [

	^ self new
		  shapes: {
				  aRMDPrettyPrintNode1.
				  aRMDPrettyPrintNode2.
				  aRMDPrettyPrintNode3 };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> with: aRMDPrettyPrintNode1 with: aRMDPrettyPrintNode2 with: aRMDPrettyPrintNode3 with: aRMDPrettyPrintNode4 [

	^ self new
		  shapes: {
				  aRMDPrettyPrintNode1.
				  aRMDPrettyPrintNode2.
				  aRMDPrettyPrintNode3.
				  aRMDPrettyPrintNode4 };
		  yourself
]

{ #category : #'instance creation' }
RMDPrettyPrintNode class >> withAll: anArrayOfRMDPrettyPrintNode [

	^ self new
		  shapes: anArrayOfRMDPrettyPrintNode;
		  yourself
]

{ #category : #arithmetics }
RMDPrettyPrintNode >> ** anIntegerOrPrettyPrintNode [

	^ anIntegerOrPrettyPrintNode isInteger
		  ifTrue: [
			  self class
				  with: self
				  with:
					  ((RMDPrettyPrintText literal:
							    anIntegerOrPrettyPrintNode printString)
						   scaleBy: 0.7;
						   translateMiddleLeftTo: self encompassingRectangle topRight;
						   yourself)
				  with: ((RMDPrettyPrintText literal: ' ')
						   scaleBy: 0.7;
						   translateMiddleLeftTo: self encompassingRectangle bottomRight;
						   yourself) ]
		  ifFalse: [
			  self class
				  with: self
				  with: (anIntegerOrPrettyPrintNode
						   scaleBy: 0.7;
						   translateMiddleLeftTo: self encompassingRectangle topRight;
						   yourself)
				  with: ((RMDPrettyPrintText literal: ' ')
						   scaleBy: 0.7;
						   translateMiddleLeftTo: self encompassingRectangle bottomRight;
						   yourself) ]
]

{ #category : #arithmetics }
RMDPrettyPrintNode >> , aRMDPrettyPrintNode [

	aRMDPrettyPrintNode translateMiddleLeftTo:
		self encompassingRectangle rightCenter + (self margin * 2 @ 0).
	^ aRMDPrettyPrintNode
]

{ #category : #arithmetics }
RMDPrettyPrintNode >> / aRMDPrettyPrintNode [

	^ self class fraction: self over: aRMDPrettyPrintNode
]

{ #category : #arithmetics }
RMDPrettyPrintNode >> enclosedByParenthesis [

	^ self class parenthesis: self
]

{ #category : #testing }
RMDPrettyPrintNode >> isPrettyPrintNode [

	^ true
]

{ #category : #accessing }
RMDPrettyPrintNode >> margin [
	^ self class margin
]

{ #category : #'user interface' }
RMDPrettyPrintNode >> openTitle: aString [

	| canvas interaction |
	canvas := RSCanvas new.
	canvas addShape: self.
	canvas @ RSCanvasController.
	interaction := RMDHoverBorderInteraction new.
	canvas allChildren do: [ :shape |
		shape isPrettyPrintNode ifTrue: [ shape @ interaction ] ].
	(canvas openWithTitle: aString) extent: 800 @ 200
]
