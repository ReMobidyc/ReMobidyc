Class {
	#name : #RMDDifferential2Node,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDDifferential2Node >> isDifferential2Node [
	^ true
]

{ #category : #accessing }
RMDDifferential2Node >> operator [
	^ 'd^2/dt^2 '
]

{ #category : #accessing }
RMDDifferential2Node >> precedence [
	^ 1
]
