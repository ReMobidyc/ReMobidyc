Class {
	#name : 'RMDLifehistoryDiagramNode',
	#superclass : 'MMNode',
	#instVars : [
		'attributes',
		'tasks'
	],
	#category : 'ReMobidyc-Diagrams-Lifehistory',
	#package : 'ReMobidyc-Diagrams',
	#tag : 'Lifehistory'
}

{ #category : 'adding' }
RMDLifehistoryDiagramNode >> addAttribute: aString [

	attributes add: aString
]

{ #category : 'adding' }
RMDLifehistoryDiagramNode >> addTask: aString [

	tasks add: aString
]

{ #category : 'accessing' }
RMDLifehistoryDiagramNode >> attributes [

	^ attributes asArray
]

{ #category : 'initialization' }
RMDLifehistoryDiagramNode >> initialize [

	super initialize.
	attributes := OrderedCollection new.
	tasks := OrderedCollection new
]

{ #category : 'accessing' }
RMDLifehistoryDiagramNode >> name: aString [

	super name: aString.
	label := aString
]

{ #category : 'accessing' }
RMDLifehistoryDiagramNode >> tasks [

	^ tasks asArray
]
