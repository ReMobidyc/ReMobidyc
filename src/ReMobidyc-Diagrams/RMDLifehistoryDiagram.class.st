Class {
	#name : 'RMDLifehistoryDiagram',
	#superclass : 'MMDiagram',
	#category : 'ReMobidyc-Diagrams-Lifehistory',
	#package : 'ReMobidyc-Diagrams',
	#tag : 'Lifehistory'
}

{ #category : 'instance creation' }
RMDLifehistoryDiagram class >> from: aRMDSimulationModel [

	| graph nodes |
	graph := self new.
	nodes := Dictionary new.
	graph entities: (Array streamContents: [ :stream |
				 aRMDSimulationModel agentDefinitionsDo: [ :agentDefinition |
						 | node |
						 node := RMDLifehistoryDiagramNode new.
						 node name: agentDefinition name.
						 agentDefinition attributeDeclarationsDo: [ :attributeDecl |
							 node addAttribute: attributeDecl nameWithUnit ].
						 nodes at: node name put: node.
						 stream nextPut: node ].
				 aRMDSimulationModel taskDefinitionsDo: [ :taskDef |
						 taskDef enabled ifTrue: [
								 nodes at: taskDef subjectIdentifier ifPresent: [ :node |
										 node addTask: taskDef verbIdentifier
											 ,
											 (taskDef objectIdentifier
												  ifNotNil: [ :obj | ' ' , obj ]
												  ifNil: [ '' ]).
										 (taskDef actionWith: aRMDSimulationModel) ifNotNil: [
												 :action |
												 (action lifeDirectives
													  detect: #isNewDirectiveNode
													  ifNone: [ nil ]) ifNotNil: [ :newDirective |
														 stream nextPut:
															 (RMDLifehistoryDiagramReproduceEdge new
																  node1: taskDef subjectIdentifier;
																  node2: newDirective animatIdentifier;
																  yourself) ].
												 (action lifeDirectives
													  detect: #isStageDirectiveNode
													  ifNone: [ nil ]) ifNotNil: [ :stageDirective |
														 stream nextPut: (RMDLifehistoryDiagramStageEdge new
																  node1: taskDef subjectIdentifier;
																  node2: stageDirective animatIdentifier;
																  yourself) ] ] ] ] ] ]).
	^ graph
]

{ #category : 'instance creation' }
RMDLifehistoryDiagram class >> from: aRMDSimulationModel species: aString [

	| graph nodes |
	graph := self new.
	nodes := Dictionary new.
	graph entities: (Array streamContents: [ :stream |
				 aRMDSimulationModel stagesOf: aString do: [ :animatDefinition |
						 | node |
						 node := RMDLifehistoryDiagramNode new.
						 node name: animatDefinition identifier.
						 animatDefinition attributeDeclarationsDo: [ :attributeDecl |
							 node addAttribute: attributeDecl nameWithUnit ].
						 nodes at: node name put: node.
						 stream nextPut: node ].
				 aRMDSimulationModel taskDefinitionsDo: [ :taskDef |
						 taskDef enabled ifTrue: [
								 nodes at: taskDef subjectIdentifier ifPresent: [ :node |
										 node addTask: taskDef verbIdentifier
											 ,
											 (taskDef objectIdentifier
												  ifNotNil: [ :obj | ' ' , obj ]
												  ifNil: [ '' ]).
										 (taskDef actionWith: aRMDSimulationModel) ifNotNil: [
												 :action |
												 (action lifeDirectives
													  detect: #isNewDirectiveNode
													  ifNone: [ nil ]) ifNotNil: [ :newDirective |
														 stream nextPut:
															 (RMDLifehistoryDiagramReproduceEdge new
																  node1: taskDef subjectIdentifier;
																  node2: newDirective animatIdentifier;
																  yourself) ].
												 (action lifeDirectives
													  detect: #isStageDirectiveNode
													  ifNone: [ nil ]) ifNotNil: [ :stageDirective |
														 stream nextPut: (RMDLifehistoryDiagramStageEdge new
																  node1: taskDef subjectIdentifier;
																  node2: stageDirective animatIdentifier;
																  yourself) ] ] ] ] ] ]).
	^ graph
]

{ #category : 'instance creation' }
RMDLifehistoryDiagram >> open [

	| canvas |
	canvas := self roassalBuilder build.
	(canvas openWithTitle: 'Life-history Diagram') maximize.
	canvas
		zoomToFit;
		@ RSCanvasController
]

{ #category : 'class access' }
RMDLifehistoryDiagram >> roassalBuilderClass [

	^ RMDLifehistoryDiagramBuilder
]
