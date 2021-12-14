Class {
	#name : #RMDTerminalTaskDefinitionNode,
	#superclass : #RMDAbstractTaskDefinitionNode,
	#instVars : [
		'propertyDefinitions',
		'utilityDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'typical instances' }
RMDTerminalTaskDefinitionNode class >> goat_die: aString [

	<script:
	'(RMDTerminalTaskDefinitionNode goat_die: ''10000[kcal]'') asPresenter openWithSpec'>
	^ ('Goat die
when my blood_sugar < ', aString, '.')
		  asRMDTaskDefinition
]

{ #category : #'instance creation' }
RMDTerminalTaskDefinitionNode class >> subjectIdentifier: agentString1 guard: aRMDConditionNode propertyDefinitions: anArrayOfRMDPropertyDefinitionNode utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	^ self new
		  subjectIdentifier: agentString1;
		  guard: aRMDConditionNode;
		  propertyDefinitions: anArrayOfRMDPropertyDefinitionNode;
		  utilityDefinitions: anArrayOfRMDUtilityDefinitionNode;
		  yourself
]

{ #category : #accessing }
RMDTerminalTaskDefinitionNode >> actionWith: aRMDInterpreter [

	^ self
]

{ #category : #private }
RMDTerminalTaskDefinitionNode >> createName [

	^ subjectIdentifier , ' die'
]

{ #category : #testing }
RMDTerminalTaskDefinitionNode >> hasObject [

	^ false
]

{ #category : #testing }
RMDTerminalTaskDefinitionNode >> isTerminalTaskDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDTerminalTaskDefinitionNode >> objectIdentifier [
	^ nil
]

{ #category : #printing }
RMDTerminalTaskDefinitionNode >> printOn: aStream [

	aStream
		nextPutAll: subjectIdentifier;
		nextPutAll: ' die'.
	guard ifNotNil: [ 
		aStream
			cr;
			nextPutAll: 'when '.
		guard printOn: aStream ].
	aStream nextPut: $.
]

{ #category : #printing }
RMDTerminalTaskDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: subjectIdentifier;
		nextPutAll: ' die'.
	guard ifNotNil: [ 
		aStream
			cr;
			nextPutAll: 'when '.
		guard
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #accessing }
RMDTerminalTaskDefinitionNode >> propertyDefinitions [

	^ propertyDefinitions
]

{ #category : #accessing }
RMDTerminalTaskDefinitionNode >> propertyDefinitions: aRMDPropertyDefinitionNode [

	propertyDefinitions := aRMDPropertyDefinitionNode
]

{ #category : #accessing }
RMDTerminalTaskDefinitionNode >> utilityDefinitions [

	^ utilityDefinitions
]

{ #category : #accessing }
RMDTerminalTaskDefinitionNode >> utilityDefinitions: anArrayOfRMDUtilityDefinition [

	utilityDefinitions := anArrayOfRMDUtilityDefinition
]

{ #category : #accessing }
RMDTerminalTaskDefinitionNode >> verbIdentifier [
	^ 'die'
]
