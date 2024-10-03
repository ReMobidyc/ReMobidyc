Class {
	#name : 'RMDAttributeDefinitionNode',
	#superclass : 'RMDDefinitionNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'typical instances' }
RMDAttributeDefinitionNode class >> template [

	<script: 'RMDAttributeDefinitionNode template inspect'>
	^ RMDAttributeDefinitionNode
		  variable:
		  (RMDAssignableAttributeVariableNode identifier: '' agent: nil)
		  expression: RMDLiteralNode zero
]

{ #category : 'converting' }
RMDAttributeDefinitionNode >> asPresenter [

	^ RMDAttributeDefinitionBrowser on: self
]

{ #category : 'accessing' }
RMDAttributeDefinitionNode >> identifier [

	^ self variable identifier
]

{ #category : 'accessing' }
RMDAttributeDefinitionNode >> identifier: aString [ 
	self variable identifier: aString
]

{ #category : 'testing' }
RMDAttributeDefinitionNode >> isAttributeDefinitionNode [
	^ true
]

{ #category : 'testing' }
RMDAttributeDefinitionNode >> isCorrectSyntax [

	^ (RMDGrammar current attributeDefinition end parse: self printString)
	  = self
]

{ #category : 'accessing' }
RMDAttributeDefinitionNode >> operator [
	^ '='
]

{ #category : 'printing' }
RMDAttributeDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: $';
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]

{ #category : 'printing' }
RMDAttributeDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	variable
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream
		nextPut: $';
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

{ #category : 'printing' }
RMDAttributeDefinitionNode >> printShortOn: aStream [

	super printShortOn: aStream.
	aStream nextPut: $'
]

{ #category : 'accessing' }
RMDAttributeDefinitionNode >> variableOperator [

	^ variable operator
]

{ #category : 'accessing' }
RMDAttributeDefinitionNode >> variableOperator: aString [

	variable := variable operator: aString
]
