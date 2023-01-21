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
RMDActionContextTest >> testLoadUtilityDefinitions [

	| parser sources |
	parser := RMDGrammar new.
	sources := #( 'one = 1' 'two = one + 1' ).
	context loadUtilityDefinitions: (sources collect: [ :source | 
			 parser utilityDefinition end parse: source ]).
	self
		assert: (context utilityAt: 'one' ifAbsent: [ nil ])
		equals: (parser utilityDefinition parse: 'one = 1').
	self
		assert: (context utilityAt: 'two' ifAbsent: [ nil ])
		equals: (parser utilityDefinition parse: 'two = one + 1')
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
			'to eat Food is
	my delta sugar'' = food''s salt.'.
	context
		subject: 10 definition: foo;
		action: eat;
		object: 20 definition: bar.
	self assert: context object equals: 20
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
