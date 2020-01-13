Class {
	#name : #RMDGreaterThanNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDGreaterThanNode >> evalIn: aRMDInterpreter [
	| val |
	val := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index | 
		| val2 |
		val2 := (expressions at: index) evalIn: aRMDInterpreter.
		val <= val2
			ifTrue: [ ^ false ].
		val := val2 ].
	^ true
]

{ #category : #testing }
RMDGreaterThanNode >> isGreaterThanNode [
	^ true
]

{ #category : #accessing }
RMDGreaterThanNode >> operator [
	^ ' > '
]
