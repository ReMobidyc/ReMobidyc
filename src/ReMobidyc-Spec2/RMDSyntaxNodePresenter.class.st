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

{ #category : #testing }
RMDSyntaxNodePresenter >> isAfterNodeChanged [

	| context |
	context := thisContext sender.
	[ context notNil ] whileTrue: [ 
		(context receiver == self and: [ context selector = #nodeChanged ]) 
			ifTrue: [ ^ true ].
		context := context sender ].
	^ false
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
