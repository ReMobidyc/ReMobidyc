Class {
	#name : #RMDEqualityNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDEqualityNode >> evalIn: aRMDInterpreter [
	| val |
	val := expressions first evalIn: aRMDInterpreter.
	2 to: expressions size do: [ :index | 
		val = ((expressions at: index) evalIn: aRMDInterpreter)
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #testing }
RMDEqualityNode >> isEqualityNode [
	^ true
]

{ #category : #accessing }
RMDEqualityNode >> operator [
	^ ' = '
]
