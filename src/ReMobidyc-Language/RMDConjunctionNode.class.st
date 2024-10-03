Class {
	#name : 'RMDConjunctionNode',
	#superclass : 'RMDBinaryCombinatorNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDConjunctionNode >> isConjunctionNode [
	^ true
]

{ #category : 'accessing' }
RMDConjunctionNode >> operator [
	^ ' and '
]
