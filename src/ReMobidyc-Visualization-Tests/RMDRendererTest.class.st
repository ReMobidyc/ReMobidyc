Class {
	#name : #RMDRendererTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'renderer'
	],
	#category : #'ReMobidyc-Visualization-Tests'
}

{ #category : #testing }
RMDRendererTest class >> isAbstract [

	^ self = RMDRendererTest
]

{ #category : #accessing }
RMDRendererTest >> renderer [

	^ self subclassResponsibility
]

{ #category : #running }
RMDRendererTest >> setUp [
	parser := RMDGrammar new renderer end.
	renderer := self renderer
]

{ #category : #tests }
RMDRendererTest >> testPrintOn [

	self assert: (parser parse: renderer printString) equals: renderer
]
