Class {
	#name : 'RMDDisjunctionNode',
	#superclass : 'RMDBinaryCombinatorNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDDisjunctionNode >> isDisjunctionNode [
	^ true
]

{ #category : 'accessing' }
RMDDisjunctionNode >> operator [
	^ ' or '
]
