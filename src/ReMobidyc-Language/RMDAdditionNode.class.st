Class {
	#name : #RMDAdditionNode,
	#superclass : #RMDLeftAssociativeApplicationNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDAdditionNode >> isAdditionNode [
	^ true
]

{ #category : #accessing }
RMDAdditionNode >> operator [
	^ '+'
]

{ #category : #accessing }
RMDAdditionNode >> precedence [
	^ 5
]
