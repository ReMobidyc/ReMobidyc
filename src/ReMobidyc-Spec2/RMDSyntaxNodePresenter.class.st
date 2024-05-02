Class {
	#name : 'RMDSyntaxNodePresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'node',
		'simulationModel'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'testing' }
RMDSyntaxNodePresenter class >> isAbstract [

	^ self == RMDSyntaxNodePresenter
]

{ #category : 'instance creation' }
RMDSyntaxNodePresenter class >> on: aRMDSyntaxNode [
	^ self new
		node: aRMDSyntaxNode;
		yourself
]

{ #category : 'testing' }
RMDSyntaxNodePresenter >> isAfterNodeChanged [

	| context |
	context := thisContext sender.
	[ context notNil ] whileTrue: [ 
		(context receiver == self and: [ context selector = #nodeChanged ]) 
			ifTrue: [ ^ true ].
		context := context sender ].
	^ false
]

{ #category : 'widgets' }
RMDSyntaxNodePresenter >> newHighlightingSyntaxNodeTextInput [

	^ super newHighlightingSyntaxNodeTextInput
		  simulationModelBlock: [ self simulationModel ];
		  yourself
]

{ #category : 'widgets' }
RMDSyntaxNodePresenter >> newSourceWith: aPP2Node [

	^ (super newSourceWith: aPP2Node)
		  simulationModelBlock: [ self simulationModel ];
		  yourself
]

{ #category : 'accessing' }
RMDSyntaxNodePresenter >> node [
	^ node
]

{ #category : 'accessing' }
RMDSyntaxNodePresenter >> node: aRMDSyntaxNode [
	node := aRMDSyntaxNode.
	self nodeChanged
]

{ #category : 'accessing' }
RMDSyntaxNodePresenter >> nodeChanged [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDSyntaxNodePresenter >> preferredHeight [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDSyntaxNodePresenter >> simulationModel [

	^ simulationModel
]

{ #category : 'accessing' }
RMDSyntaxNodePresenter >> simulationModel: aRMDSimulationModel [

	simulationModel := aRMDSimulationModel
]

{ #category : 'accessing' }
RMDSyntaxNodePresenter >> typechecker [

	^ simulationModel
		  ifNotNil: [ simulationModel typechecker ]
		  ifNil: [ RMDTypechecker new ]
]
