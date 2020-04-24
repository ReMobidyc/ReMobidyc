Class {
	#name : #RMDContextTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'context'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDContextTest >> setUp [
	context := RMDContext new.
	parser := RMDGrammar new
]

{ #category : #tests }
RMDContextTest >> testGetMemoryAddressForAgentIfAbsent [
	| animatDef |
	animatDef := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar [kcal].' trim.
	context subject: 100 definition: animatDef.
	self
		assert: (context getMemoryAddressFor: 'x' agent: nil ifAbsent: [ nil ])
		equals: (animatDef propertyOffsets at: 'x') + 100.
	self
		assert: (context getMemoryAddressFor: 'sugar' agent: nil ifAbsent: [ nil ])
		equals: (animatDef propertyOffsets at: 'sugar') + 100
]

{ #category : #tests }
RMDContextTest >> testSetMemoryAddressForAgentTo [
	context setMemoryAddressFor: 'x' agent: nil to: 1.
	context setMemoryAddressFor: 'y' agent: nil to: 2.
	context setMemoryAddressFor: 'x' agent: 'goat' to: 3.
	self
		assert: (context getMemoryAddressFor: 'x' agent: nil ifAbsent: [ nil ])
		equals: 1.
	self
		assert: (context getMemoryAddressFor: 'y' agent: nil ifAbsent: [ nil ])
		equals: 2.
	self
		assert: (context getMemoryAddressFor: 'x' agent: 'goat' ifAbsent: [ nil ])
		equals: 3
]

{ #category : #tests }
RMDContextTest >> testSubjectDefinition [
	| animatDef |
	animatDef := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar [kcal].' trim.
	context subject: 100 definition: animatDef.
	self
		assert: (context getMemoryAddressFor: 'x' agent: nil ifAbsent: [ nil ])
		equals: (animatDef propertyOffsets at: 'x') + 100.
	self
		assert: (context getMemoryAddressFor: 'sugar' agent: nil ifAbsent: [ nil ])
		equals: (animatDef propertyOffsets at: 'sugar') + 100
]
