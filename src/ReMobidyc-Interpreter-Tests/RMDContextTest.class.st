Class {
	#name : #RMDContextTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDContextTest >> setUp [
	context := RMDContext new.
]

{ #category : #tests }
RMDContextTest >> testGetMemoryAddressForAgentIfAbsent [
	context setMemoryAddressFor: 'x' agent: 'Foo' to: 1.
	context setMemoryAddressFor: 'y' agent: nil to: 2.
	self
		assert: (context getMemoryAddressFor: 'x' agent: 'Foo' ifAbsent: [ nil ])
		equals: 1.
	self
		assert: (context getMemoryAddressFor: 'y' agent: nil ifAbsent: [ nil ])
		equals: 2.
	self
		assert: (context getMemoryAddressFor: 'x' agent: nil ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (context getMemoryAddressFor: 'y' agent: 'Foo' ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (context getMemoryAddressFor: 'y' agent: 'Bar' ifAbsent: [ nil ])
		equals: nil.
	self
		assert: (context getMemoryAddressFor: 'bar' agent: 'Foo' ifAbsent: [ nil ])
		equals: nil
]

{ #category : #tests }
RMDContextTest >> testLoadPropertyBindMap [
	| parser animat replaceMap |
	parser := RMDGrammar new.
	animat := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar = 3000 [kcal].' trim.
	replaceMap := {(RMDPropertyBindNode
		scriptAgent: nil
		property: 'heading'
		animatProperty: 'heading').
	(RMDPropertyBindNode
		scriptAgent: nil
		property: 'energy'
		animatProperty: 'sugar')}.
	context
		subject: 1 species: animat;
		loadPropertyBindMap: replaceMap.
	self
		assert: (context getMemoryAddressFor: 'heading' agent: nil ifAbsent: [ nil ])
		equals: (animat propertyOffsets at: 'heading') + 1.
	self
		assert: (context getMemoryAddressFor: 'energy' agent: nil ifAbsent: [ nil ])
		equals: (animat propertyOffsets at: 'sugar') + 1
]

{ #category : #tests }
RMDContextTest >> testLoadScript [
	| parser source |
	parser := RMDGrammar new.
	source := '
to test is
	my delta x'' = two
where
	one = 1
	two = one + 1.' trim.
	context action: (parser actionDefinition parse: source).
	self
		assert: (context utilityAt: 'one' ifAbsent: [ nil ])
		equals: (parser utilityDefinition parse: 'one = 1').
	self
		assert: (context utilityAt: 'two' ifAbsent: [ nil ])
		equals: (parser utilityDefinition parse: 'two = one + 1')
]

{ #category : #tests }
RMDContextTest >> testLocationCell [
	| parser cell replaceMap |
	parser := RMDGrammar new.
	cell := parser cellDefinition
		parse:
			'
Cell with
	fertility = 3000 [kcal].' trim.
	replaceMap := {(RMDPropertyBindNode
		scriptAgent: 'here'
		property: 'sugar'
		animatProperty: 'fertility')}.
	context
		location: 10 cell: cell;
		loadPropertyBindMap: replaceMap.
	self
		assert: (context getMemoryAddressFor: 'sugar' agent: 'here' ifAbsent: [ nil ])
		equals: (cell propertyOffsets at: 'fertility') + 10
]

{ #category : #tests }
RMDContextTest >> testObjectSpecies [
	| parser foo bar replaceMap |
	parser := RMDGrammar new.
	foo := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar = 3000 [kcal].' trim.
	bar := parser animatDefinition
		parse:
			'
Bar is Animat with
	salt = 0.1 [g].' trim.
	replaceMap := {(RMDPropertyBindNode
		scriptAgent: 'bar'
		property: 'sea'
		animatProperty: 'salt')}.
	context
		subject: 10 species: foo;
		object: 20 species: bar;
		loadPropertyBindMap: replaceMap.
	self
		assert: (context getMemoryAddressFor: 'sea' agent: 'bar' ifAbsent: [ nil ])
		equals: (bar propertyOffsets at: 'salt') + 20
]

{ #category : #tests }
RMDContextTest >> testSetMemoryAddressForAgentTo [
	context setMemoryAddressFor: 'x' agent: 'Foo' to: 1.
	context setMemoryAddressFor: 'y' agent: nil to: 2.
	self
		assert: (context getMemoryAddressFor: 'x' agent: 'Foo' ifAbsent: [ nil ])
		equals: 1.
	self
		assert: (context getMemoryAddressFor: 'y' agent: nil ifAbsent: [ nil ])
		equals: 2
]

{ #category : #tests }
RMDContextTest >> testSubjectSpecies [
	| parser animat replaceMap |
	parser := RMDGrammar new.
	animat := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar = 3000 [kcal].' trim.
	replaceMap := {(RMDPropertyBindNode
		scriptAgent: nil
		property: 'energy'
		animatProperty: 'sugar')}.
	context
		subject: 10 species: animat;
		loadPropertyBindMap: replaceMap.
	self
		assert: (context getMemoryAddressFor: 'energy' agent: nil ifAbsent: [ nil ])
		equals: (animat propertyOffsets at: 'sugar') + 10
]

{ #category : #tests }
RMDContextTest >> testUtilityAtIfAbsent [
	context utilityAt: 'foo' put: 1.
	context utilityAt: 'bar' put: 2.
	self assert: (context utilityAt: 'foo' ifAbsent: [ nil ]) equals: 1.
	self assert: (context utilityAt: 'bar' ifAbsent: [ nil ]) equals: 2.
	self assert: (context utilityAt: 'buzz' ifAbsent: [ nil ]) isNil
]

{ #category : #tests }
RMDContextTest >> testUtilityAtPut [
	context utilityAt: 'foo' put: 1.
	context utilityAt: 'bar' put: 2.
	self assert: (context utilityAt: 'foo' ifAbsent: [ nil ]) equals: 1.
	self assert: (context utilityAt: 'bar' ifAbsent: [ nil ]) equals: 2
]

{ #category : #tests }
RMDContextTest >> testWorld [
	| parser world replaceMap |
	parser := RMDGrammar new.
	world := parser worldDefinition
		parse:
			'
World with
	temperature = 30 [C].' trim.
	replaceMap := {(RMDPropertyBindNode
		scriptAgent: 'world'
		property: 'temp'
		animatProperty: 'temperature')}.
	context
		world: world;
		loadPropertyBindMap: replaceMap.
	self
		assert: (context getMemoryAddressFor: 'temp' agent: 'world' ifAbsent: [ nil ])
		equals: (world propertyOffsets at: 'temperature') + 1
]
