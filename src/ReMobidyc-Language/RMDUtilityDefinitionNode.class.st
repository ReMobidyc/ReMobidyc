Class {
	#name : 'RMDUtilityDefinitionNode',
	#superclass : 'RMDDefinitionNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'typical instances' }
RMDUtilityDefinitionNode class >> template [

	<script: 'RMDUtilityDefinitionNode template inspect'>
	^ RMDUtilityDefinitionNode
		  variable: (RMDUtilityVariableNode identifier: '')
		  expression: RMDLiteralNode zero
]

{ #category : 'converting' }
RMDUtilityDefinitionNode >> asPresenter [

	"^ RMDUtilityDefinitionBrowser on: self"

	^ RMDUtilityDefinitionPresenter on: self
]

{ #category : 'enumerating' }
RMDUtilityDefinitionNode >> childrenTransform: aBlock [

	definitionBody := aBlock value: definitionBody
]

{ #category : 'accessing' }
RMDUtilityDefinitionNode >> identifier [

	^ self variable identifier
]

{ #category : 'accessing' }
RMDUtilityDefinitionNode >> identifier: aString [

	self variable identifier: aString
]

{ #category : 'testing' }
RMDUtilityDefinitionNode >> isCorrectSyntax [

	^ (RMDGrammar current utilityDefinition end parse: self printString)
	  = self
]

{ #category : 'testing' }
RMDUtilityDefinitionNode >> isCorrectTypeWithSubject: aString in: aRMDSimulationModel [

	| agentDefinition |
	agentDefinition := aRMDSimulationModel
		                   agentDefinitionAt: aString
		                   ifAbsent: [ ^ false ].
	[
	aRMDSimulationModel typechecker
		typecheck: self
		subject: aString
		object: nil
		utilities: agentDefinition utilityDefinitions ]
		on: RMDError
		do: [ :ex | ^ false ].
	^ (agentDefinition utilityDefinitions contains: [
		   :attributeDeclaration |
		   attributeDeclaration ~~ self and: [
			   attributeDeclaration identifier = self identifier ] ]) not
]

{ #category : 'testing' }
RMDUtilityDefinitionNode >> isUtilityDefinitionNode [
	^ true
]

{ #category : 'accessing' }
RMDUtilityDefinitionNode >> operator [
	^ '='
]

{ #category : 'printing' }
RMDUtilityDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]

{ #category : 'printing' }
RMDUtilityDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	variable
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
