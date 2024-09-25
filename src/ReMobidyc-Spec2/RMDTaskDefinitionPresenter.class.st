Class {
	#name : 'RMDTaskDefinitionPresenter',
	#superclass : 'RMDSyntaxNodePresenter',
	#instVars : [
		'source'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'specs' }
RMDTaskDefinitionPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical add: #source expand: true
]

{ #category : 'initialization' }
RMDTaskDefinitionPresenter >> initializePresenters [
	super initializePresenters.
	source := (self newSourceWith: RMDGrammar current taskDefinition)
		whenLastValidSyntaxNodeChangedDo: [ :newNode | 
			node
				ifNotNil: [ node subjectIdentifier: newNode subjectIdentifier.
					node actionIdentifier: newNode actionIdentifier.
					node objectIdentifier: newNode objectIdentifier.
					node range: newNode range.
					node parameterInstantiations: newNode parameterInstantiations ]
				ifNil: [ node := newNode ] ]
]

{ #category : 'widgets' }
RMDTaskDefinitionPresenter >> newSourceWith: aPP2Node [

	^ (super newSourceWith: aPP2Node)
		  subjectBlock: [ node ifNotNil: #subjectIdentifier ];
		  objectBlock: [ node ifNotNil: #objectIdentifier ];
		  yourself
]

{ #category : 'accessing' }
RMDTaskDefinitionPresenter >> nodeChanged [
	self updateSource
]

{ #category : 'accessing' }
RMDTaskDefinitionPresenter >> preferredHeight [
	^ 100
]

{ #category : 'accessing' }
RMDTaskDefinitionPresenter >> updateSource [
	source text: node printString
]
