Class {
	#name : #RMDAnimatInitializerNode,
	#superclass : #RMDAgentInitializerNode,
	#instVars : [
		'population',
		'animat'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'typical instances' }
RMDAnimatInitializerNode class >> goatInitializer: anInteger bloodSugar: aString1 to: aString2 [
	<script:
		'(RMDAnimatInitializerNode goatInitializer: 100 bloodSugar: ''10000[kcal]'' to: ''100000[kcal]'') inspect'>
	^ RMDGrammar new animatInitializer end
		parse:
			(String
				streamContents: [ :stream | 
					anInteger printOn: stream.
					stream
						nextPutAll: ' Goat with';
						cr;
						nextPutAll: '	blood_sugar = uniform ';
						nextPutAll: aString1;
						nextPutAll: ' to ';
						nextPutAll: aString2 ])
]

{ #category : #'instance creation' }
RMDAnimatInitializerNode class >> population: anInteger animat: aString attributeInitializers: anArrayOfRMDSimulationAttributeInitializerNode utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	^ self new
		  population: anInteger;
		  animat: aString;
		  attributeInitializers:
			  anArrayOfRMDSimulationAttributeInitializerNode;
		  utilityDefinitions: anArrayOfRMDUtilityDefinitionNode;
		  yourself
]

{ #category : #'typical instances' }
RMDAnimatInitializerNode class >> wolfInitializer: anInteger bloodSugar: aString1 to: aString2 [
	<script:
		'(RMDAnimatInitializerNode wolfInitializer: 20 bloodSugar: ''10000[kcal]'' to: ''50000[kcal]'') inspect'>
	^ RMDGrammar new animatInitializer end
		parse:
			(String
				streamContents: [ :stream | 
					anInteger printOn: stream.
					stream
						nextPutAll: ' Wolf with';
						cr;
						nextPutAll: '	blood_sugar = uniform ';
						nextPutAll: aString1;
						nextPutAll: ' to ';
						nextPutAll: aString2 ])
]

{ #category : #comparing }
RMDAnimatInitializerNode >> = anObject [
	^ super = anObject
		and: [ population = anObject population and: [ animat = anObject animat ] ]
]

{ #category : #accessing }
RMDAnimatInitializerNode >> agentName [

	^ self animat
]

{ #category : #accessing }
RMDAnimatInitializerNode >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatInitializerNode >> animat: aString [
	animat := aString
]

{ #category : #comparing }
RMDAnimatInitializerNode >> hash [
	^ (super hash bitXor: population hash) bitXor: animat hash
]

{ #category : #testing }
RMDAnimatInitializerNode >> isAnimatInitializerNode [
	^ true
]

{ #category : #accessing }
RMDAnimatInitializerNode >> population [
	^ population
]

{ #category : #accessing }
RMDAnimatInitializerNode >> population: anInteger [
	population := anInteger
]

{ #category : #printing }
RMDAnimatInitializerNode >> printOn: aStream [

	population printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: animat.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers
			do: [ :def | 
				aStream nextPutAll: '    '.
				def printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ]
]

{ #category : #printing }
RMDAnimatInitializerNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	population
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream
		nextPut: Character space;
		nextPutAll: animat.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers do: [ :def | 
			aStream nextPutAll: '    '.
			def
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection.
			aStream nextPut: Character cr ] ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAnimatInitializerNode >> renameAnimat: aString to: anotherString [

	animat = aString ifTrue: [ animat := anotherString ].
	super renameAnimat: aString to: anotherString
]

{ #category : #rewriting }
RMDAnimatInitializerNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary at: animat ifPresent: [ :node | animat := node copy ]
]
