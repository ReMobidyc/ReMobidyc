Class {
	#name : #RMDLessOrEqualNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDLessOrEqualNode >> evalIn: aRMDInterpreter [
	| val |
	val := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index | 
		| val2 |
		val2 := (expressions at: index) evalIn: aRMDInterpreter.
		val <= val2
			ifFalse: [ ^ false ].
		val := val2 ].
	^ true
]

{ #category : #testing }
RMDLessOrEqualNode >> isLessOrEqualNode [
	^ true
]

{ #category : #accessing }
RMDLessOrEqualNode >> operator [
	^ ' <= '
]
