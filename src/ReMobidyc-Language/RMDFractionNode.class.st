Class {
	#name : #RMDFractionNode,
	#superclass : #RMDNonAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDFractionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		/ (expression2 evalIn: aRMDInterpreter)
]

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
