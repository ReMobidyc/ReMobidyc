Class {
	#name : #RMDConditionNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDConditionNode class >> isAbstract [

	^ self == RMDConditionNode
]

{ #category : #'boolean operations' }
RMDConditionNode >> & aRMDConditionNode [

	^ aRMDConditionNode ifNil: [ self ] ifNotNil: [ 
		  RMDConjunctionNode conditions:
			  (Array with: self with: aRMDConditionNode) ]
]

{ #category : #private }
RMDConditionNode >> insertTrace [

	^ RMDTraceNode on: super insertTrace
]

{ #category : #testing }
RMDConditionNode >> isConditionNode [
	^ true
]

{ #category : #accessing }
RMDConditionNode >> precedence [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDConditionNode >> printCondition [

	^ self printString
]

{ #category : #printing }
RMDConditionNode >> printValue [

	^ '-'
]
