Class {
	#name : #RMDTypeError,
	#superclass : #RMDSemanticError,
	#instVars : [
		'type1',
		'type2',
		'subnode1',
		'subnode2'
	],
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #'instance creation' }
RMDTypeError class >> on: aRMDSyntaxNode1 subnode: aRMDSyntaxNode2 type: aRMDType2 subnode: aRMDSyntaxNode3 type: aRMDType3 [

	^ (self on: aRMDSyntaxNode1)
		  subnode1: aRMDSyntaxNode2;
		  type1: aRMDType2;
		  subnode2: aRMDSyntaxNode3;
		  type2: aRMDType3;
		  yourself
]

{ #category : #'instance creation' }
RMDTypeError class >> signal: aRMDSyntaxNode1 subnode: aRMDSyntaxNode2 type: aRMDType2 subnode: aRMDSyntaxNode3 type: aRMDType3 [

	^ (self
		   on: aRMDSyntaxNode1
		   subnode: aRMDSyntaxNode2
		   type: aRMDType2
		   subnode: aRMDSyntaxNode3
		   type: aRMDType3) signal
]

{ #category : #private }
RMDTypeError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Type error in "'.
		  node printShortOn: stream.
		  stream nextPutAll: '" : type of '.
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
RMDTypeError >> subnode1 [

	^ subnode1
]

{ #category : #accessing }
RMDTypeError >> subnode1: aRMDSyntaxNode [

	subnode1 := aRMDSyntaxNode
]

{ #category : #accessing }
RMDTypeError >> subnode2 [

	^ subnode2
]

{ #category : #accessing }
RMDTypeError >> subnode2: aRMDSyntaxNode [

	subnode2 := aRMDSyntaxNode
]

{ #category : #accessing }
RMDTypeError >> type1 [

	^ type1
]

{ #category : #accessing }
RMDTypeError >> type1: aRMDType [

	type1 := aRMDType
]

{ #category : #accessing }
RMDTypeError >> type2 [

	^ type2
]

{ #category : #accessing }
RMDTypeError >> type2: aRMDType [

	type2 := aRMDType
]
