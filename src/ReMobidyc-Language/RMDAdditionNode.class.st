Class {
	#name : #RMDAdditionNode,
	#superclass : #RMDLeftAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDAdditionNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		+ (expression2 evalIn: aRMDInterpreter)
]

{ #category : #testing }
RMDAdditionNode >> isAdditionNode [
	^ true
]

{ #category : #accessing }
RMDAdditionNode >> operator [
	^ '+'
]

{ #category : #accessing }
RMDAdditionNode >> precedence [
	^ 5
]
