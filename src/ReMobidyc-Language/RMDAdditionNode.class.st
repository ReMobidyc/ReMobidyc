Class {
	#name : 'RMDAdditionNode',
	#superclass : 'RMDLeftAssociativeApplicationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDAdditionNode >> isAdditionNode [
	^ true
]

{ #category : 'accessing' }
RMDAdditionNode >> operator [
	^ '+'
]

{ #category : 'accessing' }
RMDAdditionNode >> precedence [
	^ 5
]
