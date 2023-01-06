Class {
	#name : #RMDSemanticError,
	#superclass : #RMDError,
	#instVars : [
		'node'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #testing }
RMDSemanticError class >> isAbstract [

	^ true
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
