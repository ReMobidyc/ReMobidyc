Class {
	#name : 'RMDRemainderNode',
	#superclass : 'RMDLeftAssociativeApplicationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDRemainderNode >> isRemainderNode [

	^ true
]

{ #category : 'accessing' }
RMDRemainderNode >> operator [
	^ '%'
]

{ #category : 'accessing' }
RMDRemainderNode >> precedence [
	^ 4
]
