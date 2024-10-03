Class {
	#name : 'RMDConditionNode',
	#superclass : 'RMDSyntaxNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDConditionNode class >> isAbstract [

	^ self == RMDConditionNode
]

{ #category : 'boolean operations' }
RMDConditionNode >> & aRMDConditionNode [

	^ aRMDConditionNode ifNil: [ self ] ifNotNil: [ 
		  RMDConjunctionNode conditions:
			  (Array with: self with: aRMDConditionNode) ]
]

{ #category : 'private' }
RMDConditionNode >> insertTrace [

	^ RMDTraceNode on: super insertTrace
]

{ #category : 'testing' }
RMDConditionNode >> isConditionNode [
	^ true
]

{ #category : 'testing' }
RMDConditionNode >> isCorrectSyntax [

	^ (RMDGrammar current condition end parse: self printString) = self
]

{ #category : 'accessing' }
RMDConditionNode >> precedence [
	^ self subclassResponsibility
]

{ #category : 'printing' }
RMDConditionNode >> printCondition [

	^ self printString
]

{ #category : 'printing' }
RMDConditionNode >> printValue [

	^ '-'
]
