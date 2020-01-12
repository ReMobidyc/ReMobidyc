Class {
	#name : #RMDContextTest,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #'ReMobidyc-Language-Tests'
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
