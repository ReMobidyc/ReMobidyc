Class {
	#name : #RMDAttributeInitializerTypeError,
	#superclass : #RMDTypeError,
	#instVars : [
		'agentInitializerNode',
		'attributeInitializerNode'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDAttributeInitializerTypeError >> agentInitializerNode [

	^ agentInitializerNode
]

{ #category : #accessing }
RMDAttributeInitializerTypeError >> agentInitializerNode: aRMDAgentInitializerNode [

	agentInitializerNode := aRMDAgentInitializerNode
]

{ #category : #accessing }
RMDAttributeInitializerTypeError >> attributeInitializerNode [

	^ attributeInitializerNode
]

{ #category : #accessing }
RMDAttributeInitializerTypeError >> attributeInitializerNode: aRMDAttributeInitializerNode [

	attributeInitializerNode := aRMDAttributeInitializerNode
]

{ #category : #private }
RMDAttributeInitializerTypeError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: 'Type error in ';
			  nextPutAll: (agentInitializerNode
					   ifNotNil: #agentName
					   ifNil: [ '(unknown agent)' ]);
			  nextPutAll: '''s initializer on ';
			  nextPutAll: (attributeInitializerNode
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
