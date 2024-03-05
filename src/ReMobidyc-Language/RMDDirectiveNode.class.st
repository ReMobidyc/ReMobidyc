Class {
	#name : #RMDDirectiveNode,
	#superclass : #RMDExpressionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDirectiveNode class >> isAbstract [

	^ self = RMDDirectiveNode
]

{ #category : #enumerating }
RMDDirectiveNode >> childrenTransform: aBlock [

	
]

{ #category : #testing }
RMDDirectiveNode >> isReferenceNode [

	^ true
]

{ #category : #accessing }
RMDDirectiveNode >> precedence [
	^ 1
]

{ #category : #rewriting }
RMDDirectiveNode >> replaceChildren: aDictionary [

	
]
