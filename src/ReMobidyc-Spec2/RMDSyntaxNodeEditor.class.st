Class {
	#name : #RMDSyntaxNodeEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'node'
	],
	#category : #'ReMobidyc-Spec2'
}

{ #category : #'instance creation' }
RMDSyntaxNodeEditor class >> on: aRMDSyntaxNode [
	^ self new
		node: aRMDSyntaxNode;
		yourself
]

{ #category : #accessing }
RMDSyntaxNodeEditor >> errorColor [
	^ self theme backgroundColor mixed: 0.9 with: Color red
]

{ #category : #'instance creation' }
RMDSyntaxNodeEditor >> fromString: aString ifIntegerDo: aBlock ifError: errorBlock [
	[ ^ aBlock cull: aString trim asNumber asInteger ]
		on: Error
		do: [ :ex | errorBlock cull: aString ]
]

{ #category : #widgets }
RMDSyntaxNodeEditor >> newExpressionTextInput [
	^ self instantiate: RMDExpressionTextInputPresenter
]

{ #category : #widgets }
RMDSyntaxNodeEditor >> newNumberInput [
	^ self instantiate: RMDNumberInputPresenter
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

{ #category : #accessing }
RMDSyntaxNodeEditor >> okColor [
	^ self theme backgroundColor
]

{ #category : #accessing }
RMDSyntaxNodeEditor >> warningColor [
	^ self theme backgroundColor mixed: 0.9 with: Color yellow
]
