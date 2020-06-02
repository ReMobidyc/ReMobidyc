Class {
	#name : #RMDBehaviorDefinitionPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'source'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDBehaviorDefinitionPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical add: #source expand: true
]

{ #category : #initialization }
RMDBehaviorDefinitionPresenter >> initializePresenters [
	super initializePresenters.
	source := (self newSourceWith: RMDGrammar new behaviorDefinition)
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
RMDBehaviorDefinitionPresenter >> nodeChanged [
	self updateSource
]

{ #category : #accessing }
RMDBehaviorDefinitionPresenter >> preferredHeight [
	^ 100
]

{ #category : #accessing }
RMDBehaviorDefinitionPresenter >> updateSource [
	source text: node printString
]
