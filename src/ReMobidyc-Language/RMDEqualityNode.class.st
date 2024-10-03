Class {
	#name : 'RMDEqualityNode',
	#superclass : 'RMDBinaryRelationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDEqualityNode >> isEqualityNode [
	^ true
]

{ #category : 'accessing' }
RMDEqualityNode >> operator [
	^ ' = '
]
