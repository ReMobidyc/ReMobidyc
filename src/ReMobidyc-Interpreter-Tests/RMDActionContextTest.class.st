Class {
	#name : #RMDActionContextTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDActionContextTest >> setUp [
	context := RMDActionContext new.
]

{ #category : #tests }
RMDActionContextTest >> testAction [
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
RMDActionContextTest >> testGetMemoryAddressForAgentIfAbsent [
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
RMDActionContextTest >> testLoadUtilityDefinitions [
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
RMDActionContextTest >> testLocationDefinitionAgent [
	| parser cell |
	parser := RMDGrammar new.
	cell := parser cellDefinition end
		parse:
			'
Cell with
	grass [kcal].' trim.
	context location: 10 definition: cell agent: 'here'.
	self
		assert: (context getMemoryAddressFor: 'grass' agent: 'here' ifAbsent: [ nil ])
		equals: (cell propertyOffsets at: 'grass') + 10
]

{ #category : #tests }
RMDActionContextTest >> testObject [
	| parser foo bar eat |
	parser := RMDGrammar new.
	foo := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar [kcal].' trim.
	bar := parser animatDefinition
		parse:
			'
Bar is Animat with
	salt [g].' trim.
	eat := parser actionDefinition end
		parse:
			'to eat food is
	my delta sugar'' = food''s salt.'.
	context
		subject: 10 definition: foo;
		action: eat;
		object: 20 definition: bar.
	self assert: context object equals: 20
]

{ #category : #tests }
RMDActionContextTest >> testObjectDefinition [
	| parser foo bar eat |
	parser := RMDGrammar new.
	foo := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar [kcal].' trim.
	bar := parser animatDefinition
		parse:
			'
Bar is Animat with
	salt [g].' trim.
	eat := parser actionDefinition end
		parse:
			'to eat food is
	my delta sugar'' = food''s salt.'.
	context
		subject: 10 definition: foo;
		action: eat;
		object: 20 definition: bar.
	self
		assert: (context getMemoryAddressFor: 'sugar' agent: nil ifAbsent: [ nil ])
		equals: (foo propertyOffsets at: 'sugar') + 10.
	self
		assert: (context getMemoryAddressFor: 'salt' agent: 'food' ifAbsent: [ nil ])
		equals: (bar propertyOffsets at: 'salt') + 20.
	self assert: context objectDefinition equals: bar
]

{ #category : #tests }
RMDActionContextTest >> testSetMemoryAddressForAgentTo [
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
RMDActionContextTest >> testSubjectDefinition [
	| parser animat |
	parser := RMDGrammar new.
	animat := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar [kcal].' trim.
	context subject: 1 definition: animat.
	self
		assert: (context getMemoryAddressFor: 'x' agent: nil ifAbsent: [ nil ])
		equals: (animat propertyOffsets at: 'x') + 1.
	self
		assert: (context getMemoryAddressFor: 'sugar' agent: nil ifAbsent: [ nil ])
		equals: (animat propertyOffsets at: 'sugar') + 1
]

{ #category : #tests }
RMDActionContextTest >> testUtilityAtIfAbsent [
	context utilityAt: 'foo' put: 1.
	context utilityAt: 'bar' put: 2.
	self assert: (context utilityAt: 'foo' ifAbsent: [ nil ]) equals: 1.
	self assert: (context utilityAt: 'bar' ifAbsent: [ nil ]) equals: 2.
	self assert: (context utilityAt: 'buzz' ifAbsent: [ nil ]) isNil
]

{ #category : #tests }
RMDActionContextTest >> testUtilityAtPut [
	context utilityAt: 'foo' put: 1.
	context utilityAt: 'bar' put: 2.
	self assert: (context utilityAt: 'foo' ifAbsent: [ nil ]) equals: 1.
	self assert: (context utilityAt: 'bar' ifAbsent: [ nil ]) equals: 2
]

{ #category : #tests }
RMDActionContextTest >> testWorldDefinition [
	| parser world |
	parser := RMDGrammar new.
	world := parser worldDefinition
		parse:
			'
World with
	temperature [C].' trim.
	context world: 1 definition: world.
	self
		assert:
			(context
				getMemoryAddressFor: 'temperature'
				agent: 'world'
				ifAbsent: [ nil ])
		equals: (world propertyOffsets at: 'temperature') + 1
]
