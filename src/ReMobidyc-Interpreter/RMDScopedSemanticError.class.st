Class {
	#name : 'RMDScopedSemanticError',
	#superclass : 'RMDRuntimeError',
	#instVars : [
		'exception'
	],
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'instance creation' }
RMDScopedSemanticError class >> on: aRMDSyntaxNode exception: aRMDSemanticException [

	^ (super on: aRMDSyntaxNode)
		  exception: aRMDSemanticException;
		  yourself
]

{ #category : 'instance creation' }
RMDScopedSemanticError class >> signal: aRMDSyntaxNode exception: aRMDSemanticException [

	^ (self on: aRMDSyntaxNode exception: aRMDSemanticException) signal
]

{ #category : 'private' }
RMDScopedSemanticError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream nextPutAll: 'Error in '.
		  node printShortOn: stream.
		  stream
			  nextPutAll: ' : ';
			  nextPutAll: exception messageText ]
]

{ #category : 'accessing' }
RMDScopedSemanticError >> exception [

	^ exception
]

{ #category : 'accessing' }
RMDScopedSemanticError >> exception: aRMDSemanticError [

	exception := aRMDSemanticError
]

{ #category : 'accessing' }
RMDScopedSemanticError >> originalSemanticError [
	^ exception originalSemanticError
]
