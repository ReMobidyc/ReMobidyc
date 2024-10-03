Class {
	#name : 'RMDGreaterOrEqualNode',
	#superclass : 'RMDBinaryRelationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDGreaterOrEqualNode >> isGreaterOrEqualNode [ 
	^ true
]

{ #category : 'accessing' }
RMDGreaterOrEqualNode >> operator [
	^ ' >= '
]
