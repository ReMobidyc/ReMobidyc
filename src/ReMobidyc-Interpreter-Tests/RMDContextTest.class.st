Class {
	#name : 'RMDContextTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser',
		'context'
	],
	#category : 'ReMobidyc-Interpreter-Tests',
	#package : 'ReMobidyc-Interpreter-Tests'
}

{ #category : 'running' }
RMDContextTest >> setUp [
	context := RMDActionContext new.
	parser := RMDGrammar current
]

{ #category : 'tests' }
RMDContextTest >> testSubject [
	| animatDef |
	animatDef := parser animatDefinition
		parse:
			'
Foo is Animat with
	sugar [kcal].' trim.
	context subject: 100 definition: animatDef.
	self assert: context subject equals: 100
]
