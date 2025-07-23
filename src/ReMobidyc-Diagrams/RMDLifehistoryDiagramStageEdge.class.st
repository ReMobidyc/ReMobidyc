Class {
	#name : 'RMDLifehistoryDiagramStageEdge',
	#superclass : 'RMDLifehistoryDiagramEdge',
	#category : 'ReMobidyc-Diagrams-Lifehistory',
	#package : 'ReMobidyc-Diagrams',
	#tag : 'Lifehistory'
}

{ #category : 'accessing' }
RMDLifehistoryDiagramStageEdge >> head2 [

	^ #arrowhead
]

{ #category : 'initialization' }
RMDLifehistoryDiagramStageEdge >> initialize [

	super initialize.
	label := 'stage'
]

{ #category : 'testing' }
RMDLifehistoryDiagramStageEdge >> isTreeEdge [

	^ true
]

{ #category : 'accessing' }
RMDLifehistoryDiagramStageEdge >> linestyle [

	^ #solid
]
