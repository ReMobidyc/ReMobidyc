Class {
	#name : #RMDProductiveDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDProductiveDefinitionNode >> isProductiveDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDProductiveDefinitionNode >> operator [
	^ '<*'
]
