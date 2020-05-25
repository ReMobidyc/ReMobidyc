Class {
	#name : #RMDSyntaxNodePresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'node'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #'instance creation' }
RMDSyntaxNodePresenter class >> on: aRMDSyntaxNode [
	^ self new
		node: aRMDSyntaxNode;
		yourself
]

{ #category : #accessing }
RMDSyntaxNodePresenter >> node [
	^ node
]

{ #category : #accessing }
RMDSyntaxNodePresenter >> node: aRMDSyntaxNode [
	node := aRMDSyntaxNode.
	self nodeChanged
]

{ #category : #accessing }
RMDSyntaxNodePresenter >> nodeChanged [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDSyntaxNodePresenter >> preferredHeight [
	^ self subclassResponsibility
]
