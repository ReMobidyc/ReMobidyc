Class {
	#name : #RMDSemanticError,
	#superclass : #RMDError,
	#instVars : [
		'node'
	],
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #testing }
RMDSemanticError class >> isAbstract [

	^ self = RMDSemanticError
]

{ #category : #'instance creation' }
RMDSemanticError class >> on: aRMDSyntaxNode [

	^ self new node: aRMDSyntaxNode
]

{ #category : #'instance creation' }
RMDSemanticError class >> signal: aRMDSyntaxNode [

	^ (self on: aRMDSyntaxNode) signal
]

{ #category : #accessing }
RMDSemanticError >> node [

	^ node
]

{ #category : #accessing }
RMDSemanticError >> node: aRMDSyntaxNode [

	node := aRMDSyntaxNode
]

{ #category : #accessing }
RMDSemanticError >> originalSemanticError [

	^ self
]

{ #category : #signalling }
RMDSemanticError >> signalWithScope: aRMDSyntax [

	self resume:
		(RMDScopedSemanticError signal: aRMDSyntax exception: self)
]
