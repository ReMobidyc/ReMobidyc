Class {
	#name : #RMDFractionNode,
	#superclass : #RMDNonAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDFractionNode >> isFractionNode [ 
	^ true
]

{ #category : #accessing }
RMDFractionNode >> operator [
	^ '/'
]

{ #category : #accessing }
RMDFractionNode >> precedence [
	^ 4
]
