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
RMDSyntaxNode >> agentDirectiveNodesDo: aBlock [

	self nodesDo: [ :node | 
		node isAgentDirectiveNode ifTrue: [ aBlock cull: node ] ]
]

{ #category : #converting }
RMDSyntaxNode >> asString [

	^ self printString
]

{ #category : #enumerating }
RMDSyntaxNode >> attributeVariableNodesDo: aBlock [
	self
		nodesDo: [ :node | 
			node isAttributeVariableNode
				ifTrue: [ aBlock cull: node ] ]
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

{ #category : #testing }
RMDSyntaxNode >> hasPlaceholder [

	self nodesDo: [ :node | node isPlaceholderNode ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #comparing }
RMDSyntaxNode >> hash [
	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDSyntaxNode >> includesNode: aRMDSyntaxNode [
	self
		nodesDo: [ :node | 
			node = aRMDSyntaxNode
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isActionDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isActionsFileNode [

	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAdditionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentInitializerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAgentsFileNode [

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
RMDSyntaxNode >> isAssignableAttributeVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAssignableDeltaVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAssignableDifferentialAttributeVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAttributeBindNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAttributeDeclarationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAttributeDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAttributeInitializerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAttributeVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isBinaryRelationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isConditionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isConjunctionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDeUnitExpressionNode [

	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDieDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDisjunctionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isEnUnitExpressionNode [

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
RMDSyntaxNode >> isGammaDistributionNode [
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
RMDSyntaxNode >> isKillDirectiveNode [
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
RMDSyntaxNode >> isLifeDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLiteralNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLogLogisticDistributionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNegationNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNewAttributeVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNewDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNormalDistributionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNotEqualNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPatchDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPatchDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPatchInitializerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPlaceholderNode [

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
RMDSyntaxNode >> isSimulationDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSimulationFileNode [

	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSimulationTimeDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isStageDirectiveNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSubtractionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isTaskDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isTasksFileNode [

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
RMDSyntaxNode >> isVisualizationFileNode [

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

{ #category : #enumerating }
RMDSyntaxNode >> placeholderNodesDo: aBlock [

	self nodesDo: [ :node | 
		node isPlaceholderNode ifTrue: [ aBlock cull: node ] ]
]

{ #category : #copying }
RMDSyntaxNode >> postCopy [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDSyntaxNode >> printOn: aStream [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDSyntaxNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	^ self subclassResponsibility
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
