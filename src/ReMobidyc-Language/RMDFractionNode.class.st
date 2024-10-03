Class {
	#name : 'RMDFractionNode',
	#superclass : 'RMDLeftAssociativeApplicationNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDFractionNode >> isFractionNode [ 
	^ true
]

{ #category : 'accessing' }
RMDFractionNode >> operator [
	^ '/'
]

{ #category : 'accessing' }
RMDFractionNode >> precedence [
	^ 4
]
