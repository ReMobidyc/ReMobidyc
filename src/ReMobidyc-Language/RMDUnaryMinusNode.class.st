Class {
	#name : 'RMDUnaryMinusNode',
	#superclass : 'RMDUnaryOperatorApplicationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDUnaryMinusNode >> isUnaryMinusNode [
	^ true
]

{ #category : 'accessing' }
RMDUnaryMinusNode >> operator [
	^ '-'
]

{ #category : 'accessing' }
RMDUnaryMinusNode >> precedence [
	^ 1
]
