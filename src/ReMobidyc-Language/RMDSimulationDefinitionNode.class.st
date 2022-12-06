Class {
	#name : #RMDSimulationDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'timeDefinition',
		'worldInitializer',
		'patchInitializer',
		'animatInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSimulationDefinitionNode class >> empty [
	^ self
		timeDefinition: RMDSimulationTimeDefinitionNode empty
		worldInitializer: RMDWorldInitializerNode empty
		patchInitializer: RMDPatchInitializerNode empty
		animatInitializers: Array new
]

{ #category : #'instance creation' }
RMDSimulationDefinitionNode class >> timeDefinition: aRMDSimulationTimeDefinitionNode worldInitializer: aRMDWorldInitializerNode patchInitializer: aRMDPatchInitializerNode animatInitializers: anArrayOfRMDAnimatInitializerNode [
	<script: '(RMDSimulationDefinitionNode timeDefinition: (RMDSimulationTimeDefinitionNode during: ''100 [day]'' by: ''0.5 [day]'') worldInitializer: RMDWorldInitializerNode empty patchInitializer: (RMDPatchInitializerNode grassInitializer: 10 by: 10 of: ''1[km]'' grass: ''5000[kcal]'' to: ''10000[kcal]'') animatInitializers: {RMDAnimatInitializerNode goatInitializer}) inspect'>
	^ self new
		timeDefinition: aRMDSimulationTimeDefinitionNode;
		worldInitializer: aRMDWorldInitializerNode;
		patchInitializer: aRMDPatchInitializerNode;
		animatInitializers: anArrayOfRMDAnimatInitializerNode;
		yourself
]

{ #category : #comparing }
RMDSimulationDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ timeDefinition = anObject timeDefinition
				and: [ worldInitializer = anObject worldInitializer
						and: [ patchInitializer = anObject patchInitializer
								and: [ animatInitializers = anObject animatInitializers ] ] ] ]
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> addAnimatInitializer: aRMDAnimatInitializerNode [
	animatInitializers := animatInitializers
		copyWith: aRMDAnimatInitializerNode
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> animatInitializers [
	^ animatInitializers
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> animatInitializers: anArrayOfRMDSimulationAnimatInitializer [
	animatInitializers := anArrayOfRMDSimulationAnimatInitializer
]

{ #category : #enumerating }
RMDSimulationDefinitionNode >> childrenDo: aBlock [
	aBlock
		value: patchInitializer;
		value: timeDefinition.
	animatInitializers ifNotNil: [ animatInitializers do: aBlock ]
]

{ #category : #comparing }
RMDSimulationDefinitionNode >> hash [
	^ ((timeDefinition hash bitXor: worldInitializer hash)
		bitXor: patchInitializer hash) bitXor: animatInitializers hash
]

{ #category : #testing }
RMDSimulationDefinitionNode >> isSimulationDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> patchInitializer [
	^ patchInitializer
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> patchInitializer: aRMDSimulationPatchInitializer [
	patchInitializer := aRMDSimulationPatchInitializer
]

{ #category : #copying }
RMDSimulationDefinitionNode >> postCopy [
	timeDefinition := timeDefinition copy.
	worldInitializer := worldInitializer copy.
	patchInitializer := patchInitializer copy.
	animatInitializers := animatInitializers copy
]

{ #category : #printing }
RMDSimulationDefinitionNode >> printOn: aStream [

	aStream
		nextPutAll: 'Simulation with';
		nextPut: Character cr.
	timeDefinition printOn: aStream.
	aStream nextPut: Character cr.
	worldInitializer ifNotNil: [ 
		worldInitializer printOn: aStream.
		aStream nextPut: Character cr ].
	patchInitializer printOn: aStream.
	aStream nextPut: Character cr.
	animatInitializers
		do: [ :def | def printOn: aStream ]
		separatedBy: [ aStream nextPut: Character cr ].
	aStream nextPut: $.
]

{ #category : #printing }
RMDSimulationDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'Simulation with';
		nextPut: Character cr.
	patchInitializer
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPut: Character cr.
	timeDefinition
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPut: Character cr.
	animatInitializers
		do: [ :def | 
			def
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ]
		separatedBy: [ aStream
				nextPut: $,;
				nextPut: Character cr ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDSimulationDefinitionNode >> replaceChildren: aDictionary [
	timeDefinition := timeDefinition copyReplace: aDictionary.
	worldInitializer := worldInitializer copyReplace: aDictionary.
	patchInitializer := patchInitializer copyReplace: aDictionary.
	animatInitializers := animatInitializers
		collect: [ :node | node copyReplace: aDictionary ]
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> timeDefinition [
	^ timeDefinition
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> timeDefinition: aRMDSimulationTimeDefinitionNode [
	timeDefinition := aRMDSimulationTimeDefinitionNode
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> worldInitializer [
	^ worldInitializer
]

{ #category : #accessing }
RMDSimulationDefinitionNode >> worldInitializer: aRMDWorldInitializerNode [
	worldInitializer := aRMDWorldInitializerNode
]
