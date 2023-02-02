Class {
	#name : #RMDNumArgsError,
	#superclass : #RMDSemanticError,
	#instVars : [
		'expectedNumArgs',
		'actualNumArgs'
	],
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #'instance creation' }
RMDNumArgsError class >> on: aRMDSyntaxNode actual: anInteger expected: anotherInteger [

	^ (self on: aRMDSyntaxNode)
		  actual: anInteger;
		  expected: anotherInteger;
		  yourself
]

{ #category : #'instance creation' }
RMDNumArgsError class >> signal: aRMDSyntaxNode actual: anInteger expected: anotherInteger [

	^ (self
		   on: aRMDSyntaxNode
		   actual: anInteger
		   expected: anotherInteger) signal
]

{ #category : #accessing }
RMDNumArgsError >> actual [

	^ actualNumArgs
]

{ #category : #accessing }
RMDNumArgsError >> actual: anInteger [

	actualNumArgs := anInteger
]

{ #category : #private }
RMDNumArgsError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Wrong number of arguments in "'.
		  node printOn: stream.
		  stream nextPutAll: '" actual: '.
		  actualNumArgs printOn: stream.
		  stream nextPutAll: ' expected: '.
		  expectedNumArgs printOn: stream.
		  stream nextPutAll: '.' ]
]

{ #category : #accessing }
RMDNumArgsError >> expected [

	^ expectedNumArgs
]

{ #category : #accessing }
RMDNumArgsError >> expected: anInteger [

	expectedNumArgs := anInteger
]
