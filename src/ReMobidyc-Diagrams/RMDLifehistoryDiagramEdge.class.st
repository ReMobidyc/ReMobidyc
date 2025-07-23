Class {
	#name : 'RMDLifehistoryDiagramEdge',
	#superclass : 'MMEdge',
	#category : 'ReMobidyc-Diagrams-Lifehistory',
	#package : 'ReMobidyc-Diagrams',
	#tag : 'Lifehistory'
}

{ #category : 'testing' }
RMDLifehistoryDiagramEdge class >> isAbstract [

	^ self = RMDLifehistoryDiagramEdge
]

{ #category : 'accessing' }
RMDLifehistoryDiagramEdge >> head1 [

	^ #none
]

{ #category : 'accessing' }
RMDLifehistoryDiagramEdge >> head2 [

	^ self subclassResponsibility
]

{ #category : 'testing' }
RMDLifehistoryDiagramEdge >> isTreeEdge [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDLifehistoryDiagramEdge >> linestyle [

	^ self subclassResponsibility
]
