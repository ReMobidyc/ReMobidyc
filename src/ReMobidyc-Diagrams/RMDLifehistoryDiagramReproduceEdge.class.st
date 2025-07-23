Class {
	#name : 'RMDLifehistoryDiagramReproduceEdge',
	#superclass : 'RMDLifehistoryDiagramEdge',
	#category : 'ReMobidyc-Diagrams-Lifehistory',
	#package : 'ReMobidyc-Diagrams',
	#tag : 'Lifehistory'
}

{ #category : 'accessing' }
RMDLifehistoryDiagramReproduceEdge >> head2 [

	^ #wedgehead
]

{ #category : 'initialization' }
RMDLifehistoryDiagramReproduceEdge >> initialize [

	super initialize.
	label := 'repdoduce'
]

{ #category : 'testing' }
RMDLifehistoryDiagramReproduceEdge >> isTreeEdge [

	^ false
]

{ #category : 'accessing' }
RMDLifehistoryDiagramReproduceEdge >> linestyle [

	^ #dotted
]
