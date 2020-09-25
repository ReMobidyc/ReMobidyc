Class {
	#name : #RMDTaskDefinitionPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'source'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDTaskDefinitionPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical add: #source expand: true
]

{ #category : #initialization }
RMDTaskDefinitionPresenter >> initializePresenters [
	super initializePresenters.
	source := (self newSourceWith: RMDGrammar new taskDefinition)
		whenLastValidSyntaxNodeChangedDo: [ :newNode | 
			node
				ifNotNil: [ node subjectIdentifier: newNode subjectIdentifier.
					node actionIdentifier: newNode actionIdentifier.
					node objectIdentifier: newNode objectIdentifier.
					node range: newNode range.
					node propertyBinds: newNode propertyBinds ]
				ifNil: [ node := newNode ] ]
]

{ #category : #accessing }
RMDTaskDefinitionPresenter >> nodeChanged [
	self updateSource
]

{ #category : #accessing }
RMDTaskDefinitionPresenter >> preferredHeight [
	^ 100
]

{ #category : #accessing }
RMDTaskDefinitionPresenter >> updateSource [
	source text: node printString
]
