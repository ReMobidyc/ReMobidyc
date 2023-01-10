Class {
	#name : #RMDTaskTypeError,
	#superclass : #RMDTypeError,
	#instVars : [
		'taskDefinitionNode'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDTaskTypeError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Type error in '.
		  taskDefinitionNode printShortOn: stream.
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

{ #category : #accessing }
RMDTaskTypeError >> taskDefinitionNode [

	^ taskDefinitionNode
]

{ #category : #accessing }
RMDTaskTypeError >> taskDefinitionNode: aRMDTaskDefinitionNode [

	taskDefinitionNode := aRMDTaskDefinitionNode
]
