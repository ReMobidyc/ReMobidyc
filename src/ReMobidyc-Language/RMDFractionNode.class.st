Class {
	#name : #RMDFractionNode,
	#superclass : #RMDNonAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'type checking' }
RMDFractionNode >> inferType [
	| type1 type2 |
	type1 := expression1 inferType.
	type2 := expression2 inferType.
	(type1 notNil and: [ type2 notNil ])
		ifTrue: [ self unifyType: type1 / type2 ].
	^ type
]

{ #category : #testing }
RMDFractionNode >> isFractionNode [ 
	^ true
]

{ #category : #accessing }
RMDFractionNode >> operator [
	^ '/'
]

{ #category : #accessing }
RMDFractionNode >> precedence [
	^ 4
]
