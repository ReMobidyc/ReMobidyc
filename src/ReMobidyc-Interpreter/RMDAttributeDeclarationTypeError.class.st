Class {
	#name : #RMDAttributeDeclarationTypeError,
	#superclass : #RMDTypeError,
	#instVars : [
		'agentDefinitionNode',
		'attributeDeclarationNode'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDAttributeDeclarationTypeError >> agentDefinitionNode [

	^ agentDefinitionNode
]

{ #category : #accessing }
RMDAttributeDeclarationTypeError >> agentDefinitionNode: aRMDAgentDefinitionNode [

	agentDefinitionNode := aRMDAgentDefinitionNode
]

{ #category : #accessing }
RMDAttributeDeclarationTypeError >> attributeDeclarationNode [

	^ attributeDeclarationNode
]

{ #category : #accessing }
RMDAttributeDeclarationTypeError >> attributeDeclarationNode: aRMDAttributeDeclarationNode [

	attributeDeclarationNode := aRMDAttributeDeclarationNode
]

{ #category : #private }
RMDAttributeDeclarationTypeError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: 'Type error in ';
			  nextPutAll:
				  (agentDefinitionNode
					   ifNotNil: #agentName
					   ifNil: [ '(unknown agent)' ]);
			  nextPutAll: '''s attribute ';
			  nextPutAll: (attributeDeclarationNode
					   ifNotNil: #identifier
					   ifNil: [ '(unknown attribute)' ]).
		  stream nextPutAll: ' : type of '.
		  subnode1 printOn: stream.
		  stream nextPutAll: ' is '.
		  type1 printOn: stream.
		  node == subnode2
			  ifTrue: [ 
				  stream nextPutAll: ' but should be '.
				  type2 printOn: stream ]
			  ifFalse: [ 
				  stream nextPutAll: ' while the type of '.
				  subnode2 printOn: stream.
				  stream nextPutAll: ' is '.
				  type2 printOn: stream ].
		  stream nextPutAll: '.' ]
]
