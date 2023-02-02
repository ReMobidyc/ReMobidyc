Class {
	#name : #RMDMetaParameterSequenceNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDMetaParameterSequenceNode class >> isAbstract [

	^ self = RMDMetaParameterSequenceNode
]

{ #category : #accessing }
RMDMetaParameterSequenceNode >> dictionaryAt: anInteger ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #testing }
RMDMetaParameterSequenceNode >> isMetaParameterSequenceNode [

	^ true
]

{ #category : #accessing }
RMDMetaParameterSequenceNode >> metaParametersSize [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDMetaParameterSequenceNode >> size [

	^ self subclassResponsibility
]
