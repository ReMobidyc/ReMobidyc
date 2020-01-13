Class {
	#name : #RMDLessThanNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDLessThanNode >> evalIn: aRMDInterpreter [
	| val |
	val := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index | 
		| val2 |
		val2 := (expressions at: index) evalIn: aRMDInterpreter.
		val2 <= val
			ifTrue: [ ^ false ].
		val := val2 ].
	^ true
]

{ #category : #testing }
RMDLessThanNode >> isLessThanNode [
	^ true
]

{ #category : #accessing }
RMDLessThanNode >> operator [
	^ ' < '
]
