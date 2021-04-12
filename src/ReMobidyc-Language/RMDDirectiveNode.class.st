Class {
	#name : #RMDDirectiveNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'directive'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDDirectiveNode >> = anObject [
	^ self class = anObject class and: [ directive = anObject directive ]
]

{ #category : #accessing }
RMDDirectiveNode >> directive [
	^ directive
]

{ #category : #accessing }
RMDDirectiveNode >> directive: aString [
	directive := aString
]

{ #category : #comparing }
RMDDirectiveNode >> hash [
	^ self class hash bitXor: directive hash
]

{ #category : #'type checking' }
RMDDirectiveNode >> inferType [
	^ self unifyType: (self typeOfDirective: directive)
]

{ #category : #accessing }
RMDDirectiveNode >> precedence [
	^ 1
]

{ #category : #rewriting }
RMDDirectiveNode >> replaceChildren: aDictionary [
	aDictionary
		at: directive
		ifPresent: [ :node | directive := node copy ]
]
