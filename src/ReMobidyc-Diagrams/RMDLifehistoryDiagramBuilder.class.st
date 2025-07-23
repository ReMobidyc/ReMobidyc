Class {
	#name : 'RMDLifehistoryDiagramBuilder',
	#superclass : 'MMRoassalBuilder',
	#traits : 'MMTDagRoassalBuilder',
	#classTraits : 'MMTDagRoassalBuilder classTrait',
	#category : 'ReMobidyc-Diagrams-Lifehistory',
	#package : 'ReMobidyc-Diagrams',
	#tag : 'Lifehistory'
}

{ #category : 'private' }
RMDLifehistoryDiagramBuilder >> attach: aRSBezier from: aRSShape to: anotherRSShape in: aRSCanvas [

	| others |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	aRSShape = anotherRSShape ifTrue: [
		^ self attach: aRSBezier loopAt: aRSShape in: aRSCanvas ].
	aRSShape encompassingRectangle center y
	<= anotherRSShape encompassingRectangle center y
		ifTrue: [
				self
					attach: aRSBezier
					fromTop: aRSShape
					toTop: anotherRSShape
					in: aRSCanvas ]
		ifFalse: [
				self
					attach: aRSBezier
					fromBottom: aRSShape
					toBottom: anotherRSShape
					in: aRSCanvas ]
]

{ #category : 'private' }
RMDLifehistoryDiagramBuilder >> attach: aRSBezier fromBottom: aRSShape toBottom: anotherRSShape in: aRSCanvas [

	| margin others bottom |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	margin := gap.
	bottom := ({
		           aRSShape.
		           anotherRSShape } collect: [ :shape |
		           shape encompassingRectangle bottom ]) max.
	bottom := bottom
	          + (bottom - (aRSShape encompassingRectangle bottom max:
			            anotherRSShape encompassingRectangle bottom)) + margin.

	aRSBezier controlPoints: {
			aRSShape encompassingRectangle bottomCenter.
			(aRSShape encompassingRectangle center x @ bottom).
			(anotherRSShape encompassingRectangle center x @ bottom).
			anotherRSShape encompassingRectangle bottomCenter }
]

{ #category : 'private' }
RMDLifehistoryDiagramBuilder >> attach: aRSBezier fromTop: aRSShape toTop: anotherRSShape in: aRSCanvas [

	| margin others top |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	margin := gap.
	top := ({
		        aRSShape.
		        anotherRSShape } collect: [ :shape |
		        shape encompassingRectangle top ]) min.
	top := top + ((aRSShape encompassingRectangle top min:
		         anotherRSShape encompassingRectangle top) - top) - margin.

	aRSBezier controlPoints: {
			aRSShape encompassingRectangle topCenter.
			(aRSShape encompassingRectangle center x @ top).
			(anotherRSShape encompassingRectangle center x @ top).
			anotherRSShape encompassingRectangle topCenter }
]

{ #category : 'defaults' }
RMDLifehistoryDiagramBuilder >> defaultGap [

	^ 100
]

{ #category : 'instance creation' }
RMDLifehistoryDiagramBuilder >> newCPAPController [

	^ MMHorizontalCPAPController new
]

{ #category : 'instance creation' }
RMDLifehistoryDiagramBuilder >> newShapeForEdge: aRMDLifehistoryDiagramEdge [

	| bezier |
	bezier := RSBezier new
		          model: aRMDLifehistoryDiagramEdge;
		          color: Color black;
		          markerStart:
			          (self newMarkerFor: aRMDLifehistoryDiagramEdge head1);
		          markerEnd:
			          (self newMarkerFor: aRMDLifehistoryDiagramEdge head2);
		          yourself.
	aRMDLifehistoryDiagramEdge linestyle = #dotted ifTrue: [
		bezier dashed ].
	^ bezier
]

{ #category : 'instance creation' }
RMDLifehistoryDiagramBuilder >> newShapeForNode: aRMDLifehistoryDiagramNode [

	| nameLabel attributeLabels taskLabels extent y lastLabel rect box line1 line2 |
	nameLabel := RSLabel new
		             text: aRMDLifehistoryDiagramNode label;
		             color: Color black;
		             yourself.
	attributeLabels := aRMDLifehistoryDiagramNode attributes collect: [
			                   :attribute |
			                   RSLabel new
				                   text: attribute;
				                   color: Color darkGray;
				                   yourself ].
	taskLabels := aRMDLifehistoryDiagramNode tasks collect: [ :task |
			              RSLabel new
				              text: task;
				              color: Color darkGray;
				              yourself ].
	extent := (attributeLabels , taskLabels
		           inject: nameLabel extent
		           into: [ :e :l | (e x max: l width) @ (e y + l height) ])
	          + (0 @ 10).
	y := extent y / -2.
	nameLabel translateTo:
		nameLabel position x @ (y + (nameLabel height / 2)).
	line1 := RSLine new
		         startPoint:
			         extent x / -2 - 5
			         @ (nameLabel encompassingRectangle bottom + 2.5);
		         endPoint:
			         extent x / 2 + 5
			         @ (nameLabel encompassingRectangle bottom + 2.5);
		         color: Color darkGray;
		         yourself.
	y := y + nameLabel height + 5.
	attributeLabels do: [ :attributeLabel |
			attributeLabel position: attributeLabel width - extent x / 2
				@ (y + (attributeLabel height / 2)).
			y := y + attributeLabel height ].
	lastLabel := attributeLabels ifNotEmpty: #last ifEmpty: [ nameLabel ].
	line2 := RSLine new
		         startPoint:
			         extent x / -2 - 5
			         @ (lastLabel encompassingRectangle bottom + 2.5);
		         endPoint:
			         extent x / 2 + 5
			         @ (lastLabel encompassingRectangle bottom + 2.5);
		         color: Color darkGray;
		         yourself.
	y := y + 5.
	taskLabels do: [ :taskLabel |
			taskLabel position:
				taskLabel width - extent x / 2 @ (y + (taskLabel height / 2)).
			y := y + taskLabel height ].
	rect := ({ nameLabel } , attributeLabels , taskLabels as: RSGroup)
		        encompassingRectangle.
	box := RSBox new
		       cornerRadius: 5;
		       extent: rect extent + (10 @ 10);
		       color: Color white;
		       border: (RSBorder new color: Color black);
		       yourself.
	^ {
		  box.
		  nameLabel.
		  line1.
		  line2 } , attributeLabels , taskLabels asShapeFor:
		  aRMDLifehistoryDiagramNode
]

{ #category : 'instance creation' }
RMDLifehistoryDiagramBuilder >> newTreeLayouter [

	^ RSHorizontalVanDerPloegTreeLayout new
		  verticalGap: gap;
		  horizontalGap: gap
]

{ #category : 'accessing' }
RMDLifehistoryDiagramBuilder >> treeEdges [

	| knownNodes |
	knownNodes := Set new: nodes size.
	^ Array streamContents: [ :stream |
			  edges select: #isTreeEdge thenDo: [ :edge |
					  | node2 |
					  node2 := edge node2.
					  (knownNodes includes: node2) ifFalse: [
							  knownNodes add: node2.
							  stream nextPut: edge ] ] ]
]
