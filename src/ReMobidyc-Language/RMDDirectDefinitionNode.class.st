Class {
	#name : #RMDDirectDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDDirectDefinitionNode >> isDirectDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDDirectDefinitionNode >> operator [
	^ '='
]
