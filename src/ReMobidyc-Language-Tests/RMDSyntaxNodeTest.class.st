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

{ #category : #utilities }
RMDSyntaxNodeTest >> expression: aString [
	^ parser expression end parse: aString
]

{ #category : #running }
RMDSyntaxNodeTest >> setUp [
	(self class allSelectors
		select:
			[ :selector | selector size > 5 and: [ (selector copyFrom: 1 to: 5) = 'setUp' ] ])
		do: [ :selector | self perform: selector ]
]

{ #category : #running }
RMDSyntaxNodeTest >> setUpParser [
	parser := RMDGrammar new
]
