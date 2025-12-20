Class {
	#name : 'RMDMetaContextTest',
	#superclass : 'TestCase',
	#instVars : [
		'context'
	],
	#category : 'ReMobidyc-Interpreter-Tests',
	#package : 'ReMobidyc-Interpreter-Tests'
}

{ #category : 'running' }
RMDMetaContextTest >> setUp [
	context := RMDMetaContext new
]

{ #category : 'tests' }
RMDMetaContextTest >> testInterpreterAtIfAbsent [

	| i1 i2 |
	i1 := Object new.
	i2 := Object new.
	context instVarNamed: 'interpreters' put: { 
			i1.
			i2 }.
	self assert: (context interpreterAt: 1 ifAbsent: [ nil ]) equals: i1.
	self assert: (context interpreterAt: 2 ifAbsent: [ nil ]) equals: i2.
	self assert: (context interpreterAt: 3 ifAbsent: [ nil ]) equals: nil
]
