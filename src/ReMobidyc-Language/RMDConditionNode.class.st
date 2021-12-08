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

{ #category : #accessing }
RMDConditionNode >> precedence [
	^ self subclassResponsibility
]
