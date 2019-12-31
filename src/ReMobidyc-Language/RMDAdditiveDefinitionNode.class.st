Class {
	#name : #RMDAdditiveDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDAdditiveDefinitionNode >> isAdditiveDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDAdditiveDefinitionNode >> operator [
	^ '<+'
]
