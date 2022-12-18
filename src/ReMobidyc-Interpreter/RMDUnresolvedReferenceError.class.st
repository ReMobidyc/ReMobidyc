Class {
	#name : #RMDUnresolvedReferenceError,
	#superclass : #RMDError,
	#instVars : [
		'node'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDUnresolvedReferenceError class >> on: aRMDSyntaxNode [

	^ self new
		  node: aRMDSyntaxNode;
		  yourself
]

{ #category : #'instance creation' }
RMDUnresolvedReferenceError class >> signal: aRMDSyntaxNode [

	^ (self on: aRMDSyntaxNode) signal
]

{ #category : #accessing }
RMDUnresolvedReferenceError >> node [
	^ node
]

{ #category : #accessing }
RMDUnresolvedReferenceError >> node: aRMDSyntaxNode [
	node := aRMDSyntaxNode
]
