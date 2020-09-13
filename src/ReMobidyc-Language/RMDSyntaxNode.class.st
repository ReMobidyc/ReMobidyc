Class {
	#name : #RMDSyntaxNode,
	#superclass : #Object,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDSyntaxNode >> = anObject [
	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDSyntaxNode >> childrenDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #rewriting }
RMDSyntaxNode >> copyReplace: aDictionary [
	aDictionary at: self ifPresent: [ :node | ^ node copy ].
	^ self shallowCopy replaceChildren: aDictionary
]

{ #category : #comparing }
RMDSyntaxNode >> hash [
	^ self subclassResponsibility
]

{ #category : #testing }
RMDSyntaxNode >> isActionDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isActionIdentifierNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAdditionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentReferenceNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAnimatDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAnimatInitializerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isApplyNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAssignableDeltaVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAssignableDifferentialPropertyVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAssignablePropertyVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isBehaviorDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isBinaryRelationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isBuiltinActionIdentifierNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isCellDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isCellDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isCellInitializerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isConjunctionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDifferential2VariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDisjunctionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isEqualityNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isExpressionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isFractionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isGreaterOrEqualNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isGreaterThanNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isGuardedChoiceNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLessOrEqualNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLessThanNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLiteralNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLocalActionIdentifierNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNegationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNextVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNotEqualNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isOldNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPowerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isProductNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyAdditiveDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyBindNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyDeclarationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyInitializerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyProductiveDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPropertyVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSimulationDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSimulationTimeDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSpeciesDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSpeciesInitializerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSubtractionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUnaryMinusNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUniformDistributionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUtilityDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isUtilityVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isWorldDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isWorldInitializerNode [
	^ false
]

{ #category : #enumerating }
RMDSyntaxNode >> nodesDo: aBlock [
	aBlock value: self.
	self childrenDo: [ :node | node nodesDo: aBlock ]
]

{ #category : #enumerating }
RMDSyntaxNode >> nodesSuchThat: condition do: aBlock [
	(condition value: self)
		ifTrue: [ aBlock value: self ].
	self childrenDo: [ :node | node nodesSuchThat: condition do: aBlock ]
]

{ #category : #copying }
RMDSyntaxNode >> postCopy [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDSyntaxNode >> printOn: aStream [
	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDSyntaxNode >> propertyVariableNodesDo: aBlock [
	self
		nodesDo: [ :node | 
			node isPropertyVariableNode
				ifTrue: [ aBlock cull: node ] ]
]

{ #category : #rewriting }
RMDSyntaxNode >> replaceChildren: aDictionary [
	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDSyntaxNode >> utilityVariableNodesDo: aBlock [
	self
		nodesDo: [ :node | 
			node isUtilityVariableNode
				ifTrue: [ aBlock cull: node ] ]
]
