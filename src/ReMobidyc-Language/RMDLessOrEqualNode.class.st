Class {
	#name : 'RMDLessOrEqualNode',
	#superclass : 'RMDBinaryRelationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDLessOrEqualNode >> isLessOrEqualNode [
	^ true
]

{ #category : 'accessing' }
RMDLessOrEqualNode >> operator [
	^ ' <= '
]
