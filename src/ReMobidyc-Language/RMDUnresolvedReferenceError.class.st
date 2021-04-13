Class {
	#name : #RMDUnresolvedReferenceError,
	#superclass : #Exception,
	#instVars : [
		'ast'
	],
	#category : #'ReMobidyc-Language-Type'
}

{ #category : #'instance creation' }
RMDUnresolvedReferenceError class >> on: aRMDSyntaxNode [
	^ self new
		ast: aRMDSyntaxNode;
		messageText: aRMDSyntaxNode printString;
		yourself
]

{ #category : #accessing }
RMDUnresolvedReferenceError >> ast [
	^ ast
]

{ #category : #accessing }
RMDUnresolvedReferenceError >> ast: aRMDSyntaxNode [
	ast := aRMDSyntaxNode
]

{ #category : #accessing }
RMDUnresolvedReferenceError >> defaultAction [
	^ UnhandledError signalForException: self
]
