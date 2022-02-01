Class {
	#name : #RMDActionDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'object',
		'guard',
		'lifeDirectives',
		'utilityDefinitions',
		'attributeDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDActionDefinitionNode class >> name: scriptName object: objectName guard: aRMDCondition lifeDirectives: anArrayOfRMDLifeDirective attributeDefinitions: anArrayOfRMDAttributeDefinition utilityDefinitions: anArrayOfRMDUtilityDefinition [

	^ self new
		  identifier: scriptName;
		  object: objectName;
		  guard: aRMDCondition;
		  lifeDirectives: anArrayOfRMDLifeDirective;
		  attributeDefinitions:
			  (anArrayOfRMDAttributeDefinition ifNil: [ Array new ]);
		  utilityDefinitions:
			  (anArrayOfRMDUtilityDefinition ifNil: [ Array new ]);
		  yourself
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> prey_on [
	<script: 'RMDActionDefinitionNode prey_on inspect'>
	^ 'to prey_on Prey is
when my blood_sugar < the threshold
with kill
	my delta blood_sugar'' = prey''s blood_sugar.' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> reproduce [
	<script: 'RMDActionDefinitionNode reproduce inspect'>
	^ 'to reproduce is
when my blood_sugar > the min_blood_sugar and uniform 0 to 1 < the chance 
with new -
	new delta x'' = uniform -1[m] to 1[m]
	new delta y'' = uniform -1[m] to 1[m]
	new blood_sugar'' = the initial_blood_sugar
	my delta blood_sugar'' = -the reproduction_cost.' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> template [
	<script: 'RMDActionDefinitionNode template inspect'>
	^ 'to verb is.' asRMDActionDefinition
]

{ #category : #'instance creation' }
RMDActionDefinitionNode class >> withAll: aCollectionOfRMDActionDefinitionNode [
	| variables actionDefinition |
	variables := Dictionary new.
	aCollectionOfRMDActionDefinitionNode
		do: [ :action | 
			| vars |
			vars := Set new.
			action
				nodesDo: [ :node | 
					(node isAttributeVariableNode or: [ node isUtilityVariableNode ])
						ifTrue: [ vars add: node ] ].
			vars
				do:
					[ :var | (variables at: var ifAbsentPut: [ OrderedCollection new ]) add: action ] ].
	actionDefinition := aCollectionOfRMDActionDefinitionNode
		inject:
			(self
				name: ''
				object: nil
				guard: nil
				lifeDirectives: Array new
				attributeDefinitions: Array new
				utilityDefinitions: Array new)
		into: [ :composite :action | 
			composite
				+
					(action
						copyReplace:
							(variables associations
								select:
									[ :assoc | assoc value size >= 2 and: [ assoc value includes: action ] ]
								thenCollect: [ :assoc | 
									assoc key
										->
											(assoc key copy
												identifier: assoc key identifier , '_' , action identifier;
												yourself) ]) asDictionary) ].
	actionDefinition identifier first = $_
		ifTrue: [ actionDefinition
				identifier: (actionDefinition identifier allButFirst: 1) ].
	(actionDefinition object notNil
		and: [ actionDefinition object first = $_ ])
		ifTrue: [ actionDefinition object: (actionDefinition object allButFirst: 1) ].
	^ actionDefinition
]

{ #category : #accessing }
RMDActionDefinitionNode >> + aRMDActionDefinitionNode [
	^ self class
		name: identifier , '_' , aRMDActionDefinitionNode identifier
		object:
			(object
				ifNil: [ aRMDActionDefinitionNode object ]
				ifNotNil: [ aRMDActionDefinitionNode object
						ifNil: [ object ]
						ifNotNil: [ object , '_' , aRMDActionDefinitionNode object ] ])
		guard:
			(guard
				ifNil: [ aRMDActionDefinitionNode guard ]
				ifNotNil: [ aRMDActionDefinitionNode guard
						ifNil: [ guard ]
						ifNotNil: [ RMDConjunctionNode
								conditions:
									{guard.
									aRMDActionDefinitionNode guard} ] ])
		lifeDirectives: lifeDirectives , aRMDActionDefinitionNode lifeDirectives
		attributeDefinitions: attributeDefinitions , aRMDActionDefinitionNode attributeDefinitions
		utilityDefinitions: utilityDefinitions , aRMDActionDefinitionNode utilityDefinitions
]

{ #category : #comparing }
RMDActionDefinitionNode >> = anObject [

	^ self class = anObject class and: [ 
		  identifier = anObject identifier and: [ 
			  object = anObject object and: [ 
				  guard = anObject guard and: [ 
					  lifeDirectives = anObject lifeDirectives and: [ 
						  attributeDefinitions = anObject attributeDefinitions and: [ 
							  utilityDefinitions = anObject utilityDefinitions ] ] ] ] ] ]
]

{ #category : #converting }
RMDActionDefinitionNode >> asPresenter [

	^ RMDActionDefinitionBrowser on: self
]

{ #category : #accessing }
RMDActionDefinitionNode >> attributeDefinitions [
	^ attributeDefinitions
]

{ #category : #accessing }
RMDActionDefinitionNode >> attributeDefinitions: aRMDAttributeDefinitionNode [
	attributeDefinitions := aRMDAttributeDefinitionNode
]

{ #category : #enumerating }
RMDActionDefinitionNode >> childrenDo: aBlock [

	guard ifNotNil: aBlock.
	lifeDirectives do: aBlock.
	attributeDefinitions do: aBlock.
	utilityDefinitions do: aBlock
]

{ #category : #accessing }
RMDActionDefinitionNode >> guard [
	^ guard
]

{ #category : #accessing }
RMDActionDefinitionNode >> guard: aRMDCondition [
	guard := aRMDCondition
]

{ #category : #testing }
RMDActionDefinitionNode >> hasObject [
	^ object notNil
]

{ #category : #comparing }
RMDActionDefinitionNode >> hash [

	^ ((((identifier hash bitXor: object hash) bitXor: guard hash) 
		    bitXor: lifeDirectives hash) bitXor: attributeDefinitions hash) 
		  bitXor: utilityDefinitions hash
]

{ #category : #accessing }
RMDActionDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDActionDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDActionDefinitionNode >> isActionDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDActionDefinitionNode >> lifeDirectives [
	^ lifeDirectives
]

{ #category : #accessing }
RMDActionDefinitionNode >> lifeDirectives: anArrayOfRMDLifeDirective [

	lifeDirectives := anArrayOfRMDLifeDirective
]

{ #category : #accessing }
RMDActionDefinitionNode >> object [
	^ object
]

{ #category : #accessing }
RMDActionDefinitionNode >> object: aString [
	object := aString
]

{ #category : #copying }
RMDActionDefinitionNode >> postCopy [

	guard := guard ifNotNil: [ guard copy ].
	lifeDirectives := lifeDirectives ifNotNil: [ 
		                  lifeDirectives collect: #copy ].
	attributeDefinitions := attributeDefinitions ifNotNil: [ 
		                       attributeDefinitions collect: #copy ].
	utilityDefinitions := utilityDefinitions ifNotNil: [ 
		                      utilityDefinitions collect: #copy ]
]

{ #category : #printing }
RMDActionDefinitionNode >> printOn: aStream [

	aStream
		nextPutAll: 'to ';
		nextPutAll: identifier.
	object ifNotNil: [ 
		aStream
			nextPut: Character space;
			nextPutAll: object ].
	aStream nextPutAll: ' is'.
	guard notNil ifTrue: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: '    when '.
		guard printOn: aStream ].
	lifeDirectives ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: '    with '.
		lifeDirectives
			do: [ :directive | directive printOn: aStream ]
			separatedBy: [ aStream nextPutAll: ', ' ] ].
	attributeDefinitions do: [ :def | 
		aStream
			nextPut: Character cr;
			nextPutAll: '    '.
		def printOn: aStream ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	aStream
		nextPut: $.;
		nextPut: Character cr
]

{ #category : #printing }
RMDActionDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'to ';
		nextPutAll: identifier.
	object ifNotNil: [ 
		aStream
			nextPut: Character space;
			nextPutAll: object ].
	aStream nextPutAll: ' is'.
	guard notNil ifTrue: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: '    when '.
		guard
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ].
	lifeDirectives ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: '    with '.
		lifeDirectives
			do: [ :directive | 
				directive
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPutAll: ', ' ] ].
	attributeDefinitions do: [ :def | 
		aStream
			nextPut: Character cr;
			nextPutAll: '    '.
		def
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ].
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
	aStream
		nextPut: $.;
		nextPut: Character cr.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDActionDefinitionNode >> replaceChildren: aDictionary [

	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ].
	aDictionary at: object ifPresent: [ :node | object := node copy ].
	(guard isKindOf: RMDSyntaxNode)
		ifTrue: [ guard := guard copyReplace: aDictionary ]
		ifFalse: [ 
		aDictionary at: guard ifPresent: [ :node | guard := node copy ] ].
	lifeDirectives := lifeDirectives collect: [ :node | 
		                  node copyReplace: aDictionary ].
	attributeDefinitions := attributeDefinitions collect: [ :node | 
		                       node copyReplace: aDictionary ].
	utilityDefinitions := utilityDefinitions collect: [ :node | 
		                      node copyReplace: aDictionary ]
]

{ #category : #accessing }
RMDActionDefinitionNode >> replaceObjectWith: aString [

	| objectName agentName |
	aString ifNil: [ ^ self ].
	objectName := object ifNotNil: #uncapitalized.
	agentName := aString uncapitalized.
	objectName ifNotNil: [ 
		self attributeVariableNodesDo: [ :attributeVariableNode | 
			attributeVariableNode agent = objectName ifTrue: [ 
				attributeVariableNode agent: agentName ] ].
		self agentDirectiveNodesDo: [ :directive | 
			directive agentIdentifier = objectName ifTrue: [ 
				directive agentIdentifier: agentName ] ] ].
	object := aString capitalized
]

{ #category : #accessing }
RMDActionDefinitionNode >> taskGuard: aRMDConditionNode [

	aRMDConditionNode ifNil: [ ^ self ].
	guard := guard
		         ifNil: [ aRMDConditionNode ]
		         ifNotNil: [ guard & aRMDConditionNode ]
]

{ #category : #accessing }
RMDActionDefinitionNode >> utilityDefinitions [
	^ utilityDefinitions
]

{ #category : #accessing }
RMDActionDefinitionNode >> utilityDefinitions: anArrayOfRMDUtilityDefinition [
	utilityDefinitions := anArrayOfRMDUtilityDefinition
]
