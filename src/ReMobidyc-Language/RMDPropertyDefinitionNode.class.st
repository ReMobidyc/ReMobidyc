Class {
	#name : #RMDPropertyDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'typical instances' }
RMDPropertyDefinitionNode class >> template [

	<script: 'RMDPropertyDefinitionNode template inspect'>
	^ RMDPropertyDefinitionNode
		  variable:
		  (RMDAssignablePropertyVariableNode identifier: 'var' agent: nil)
		  expression: RMDLiteralNode zero
]

{ #category : #converting }
RMDPropertyDefinitionNode >> asPresenter [

	^ RMDPropertyDefinitionBrowser on: self
]

{ #category : #testing }
RMDPropertyDefinitionNode >> isPropertyDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPropertyDefinitionNode >> operator [
	^ '='
]

{ #category : #printing }
RMDPropertyDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: $';
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]

{ #category : #printing }
RMDPropertyDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
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
