Class {
	#name : #RMDSyntaxNodeEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'node'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #'instance creation' }
RMDSyntaxNodeEditor class >> on: aRMDSyntaxNode [
	^ self new
		node: aRMDSyntaxNode;
		yourself
]

{ #category : #accessing }
RMDSyntaxNodeEditor >> node [
	^ node
]

{ #category : #accessing }
RMDSyntaxNodeEditor >> node: aRMDSyntaxNode [
	node := aRMDSyntaxNode.
	self nodeChanged
]

{ #category : #accessing }
RMDSyntaxNodeEditor >> nodeChanged [
	^ self subclassResponsibility
]
