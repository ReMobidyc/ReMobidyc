Class {
	#name : #RMDConditionNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'boolean operations' }
RMDConditionNode >> & aRMDConditionNode [

	^ aRMDConditionNode ifNil: [ self ] ifNotNil: [ 
		  RMDConjunctionNode conditions:
			  (Array with: self with: aRMDConditionNode) ]
]

{ #category : #testing }
RMDConditionNode >> isConditionNode [
	^ true
]

{ #category : #accessing }
RMDConditionNode >> precedence [
	^ self subclassResponsibility
]
