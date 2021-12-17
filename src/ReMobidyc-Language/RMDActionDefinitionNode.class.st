Class {
	#name : #RMDActionDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'object',
		'guard',
		'lifeDirectives',
		'propertyDefinitions',
		'utilityDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> collect [
	<script: 'RMDActionDefinitionNode collect inspect'>
	^ 'to collect is
	here''s delta thing'' = - amount
	my delta thing'' = amount
where
	amount = min(my greed, here''s thing).
' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> collect_if_below [
	<script: 'RMDActionDefinitionNode collect_if_below inspect'>
	^ 'to collect_if_below is
	when my thing < my threshold
	here''s delta thing'' = - amount
	my delta thing'' = amount
where
	amount = min(my greed, here''s thing).
' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> convert [
	<script: 'RMDActionDefinitionNode convert inspect'>
	^ 'to convert is
	my delta new_form'' = amount
	my delta old_form'' = -amount
where
	amout = my amount.
' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> diffuse [
	<script: 'RMDActionDefinitionNode diffuse inspect'>
	^ 'to diffuse is
	here''s delta thing'' = amount
	my delta thing'' = -amount
where
	amount = my amount.
' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> gain [
	<script: 'RMDActionDefinitionNode lose gain'>
	^ RMDBuiltinRepository current gain
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> graze [
	<script: 'RMDActionDefinitionNode graze inspect'>
	^ 'to graze is
when here''s grass > 0[kcal] and my energy < my max_energy
	here''s delta grass'' = -amount
	my delta energy'' = amount
where
	amount = min(my max_energy - my energy, my diet * delta time, here''s grass).
' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> grow_grass [
	<script: 'RMDActionDefinitionNode grow_grass inspect'>
	^ 'to grow_grass is
when here''s grass < here''s max_grass
	here''s delta grass'' = min(here''s growth_rate * delta time, here''s max_grass - here''s grass).' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> lose [
	<script: 'RMDActionDefinitionNode lose inspect'>
	^ 'to lose is
	my delta thing'' = - my amount.' asRMDActionDefinition
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> move [
	<script: 'RMDActionDefinitionNode move inspect'>
	^ 'to move is
	my d/dt x'' = cos(theta) * r
	my d/dt y'' = sin(theta) * r
where
	theta = my heading
	r = my speed.' asRMDActionDefinition
]

{ #category : #'instance creation' }
RMDActionDefinitionNode class >> name: scriptName object: objectName guard: aRMDCondition lifeDirectives: anArrayOfRMDLifeDirective propertyDefinitions: anArrayOfRMDPropertyDefinition utilityDefinitions: anArrayOfRMDUtilityDefinition [

	^ self new
		  identifier: scriptName;
		  object: objectName;
		  guard: aRMDCondition;
		  lifeDirectives: anArrayOfRMDLifeDirective;
		  propertyDefinitions:
			  (anArrayOfRMDPropertyDefinition ifNil: [ Array new ]);
		  utilityDefinitions:
			  (anArrayOfRMDUtilityDefinition ifNil: [ Array new ]);
		  yourself
]

{ #category : #'typical instances' }
RMDActionDefinitionNode class >> respire [
	<script: 'RMDActionDefinitionNode respire inspect'>
	^ 'to respire is
	my delta energy'' = - my respiration_rate * delta time.' asRMDActionDefinition
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
					(node isPropertyVariableNode or: [ node isUtilityVariableNode ])
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
				propertyDefinitions: Array new
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
		propertyDefinitions: propertyDefinitions , aRMDActionDefinitionNode propertyDefinitions
		utilityDefinitions: utilityDefinitions , aRMDActionDefinitionNode utilityDefinitions
]

{ #category : #comparing }
RMDActionDefinitionNode >> = anObject [

	^ self class = anObject class and: [ 
		  identifier = anObject identifier and: [ 
			  object = anObject object and: [ 
				  guard = anObject guard and: [ 
					  lifeDirectives = anObject lifeDirectives and: [ 
						  propertyDefinitions = anObject propertyDefinitions and: [ 
							  utilityDefinitions = anObject utilityDefinitions ] ] ] ] ] ]
]

{ #category : #enumerating }
RMDActionDefinitionNode >> childrenDo: aBlock [

	guard ifNotNil: aBlock.
	lifeDirectives do: aBlock.
	propertyDefinitions do: aBlock.
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
		    bitXor: lifeDirectives hash) bitXor: propertyDefinitions hash) 
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
	propertyDefinitions := propertyDefinitions ifNotNil: [ 
		                       propertyDefinitions collect: #copy ].
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
	propertyDefinitions do: [ :def | 
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
	propertyDefinitions do: [ :def | 
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

{ #category : #accessing }
RMDActionDefinitionNode >> propertyDefinitions [
	^ propertyDefinitions
]

{ #category : #accessing }
RMDActionDefinitionNode >> propertyDefinitions: aRMDPropertyDefinitionNode [
	propertyDefinitions := aRMDPropertyDefinitionNode
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
	propertyDefinitions := propertyDefinitions collect: [ :node | 
		                       node copyReplace: aDictionary ].
	utilityDefinitions := utilityDefinitions collect: [ :node | 
		                      node copyReplace: aDictionary ]
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
