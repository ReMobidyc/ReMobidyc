Class {
	#name : 'RMDGreaterThanNode',
	#superclass : 'RMDBinaryRelationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDGreaterThanNode >> isGreaterThanNode [
	^ true
]

{ #category : 'accessing' }
RMDGreaterThanNode >> operator [
	^ ' > '
]
