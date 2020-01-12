Class {
	#name : #RMDSyntaxNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #testing }
RMDSyntaxNodeTest class >> isAbstract [
	^ self name = #RMDSyntaxNodeTest
]

{ #category : #running }
RMDSyntaxNodeTest >> setUp [
	interpreter := RMDInterpreter new
		setMemory: RMDOnMemory new;
		setContext: RMDContext new;
		yourself.
	parser := RMDGrammar new
]
