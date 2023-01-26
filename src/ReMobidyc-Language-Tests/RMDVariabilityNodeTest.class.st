Class {
	#name : #RMDVariabilityNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDVariabilityNodeTest >> testDictionariesDo [

	| variability dicts |
	variability := parser variability end parse: 'Variability with
	reproduce random 1
	10 runs each
	the p -> 1, 2
	the q, the r -> (3, 4), (5, 6), (7, 8).'.
	dicts := Array streamContents: [ :stream | 
		         variability dictionariesDo: [ :dict | stream nextPut: dict ] ].
	self assert: (dicts at: 1) equals: { 
			('the p' asRMDExpression -> '1' asRMDExpression).
			('the q' asRMDExpression -> '3' asRMDExpression).
			('the r' asRMDExpression -> '4' asRMDExpression) } asDictionary.
	self assert: (dicts at: 2) equals: { 
			('the p' asRMDExpression -> '2' asRMDExpression).
			('the q' asRMDExpression -> '3' asRMDExpression).
			('the r' asRMDExpression -> '4' asRMDExpression) } asDictionary.
	self assert: (dicts at: 3) equals: { 
			('the p' asRMDExpression -> '1' asRMDExpression).
			('the q' asRMDExpression -> '5' asRMDExpression).
			('the r' asRMDExpression -> '6' asRMDExpression) } asDictionary.
	self assert: (dicts at: 4) equals: { 
			('the p' asRMDExpression -> '2' asRMDExpression).
			('the q' asRMDExpression -> '5' asRMDExpression).
			('the r' asRMDExpression -> '6' asRMDExpression) } asDictionary.
	self assert: (dicts at: 5) equals: { 
			('the p' asRMDExpression -> '1' asRMDExpression).
			('the q' asRMDExpression -> '7' asRMDExpression).
			('the r' asRMDExpression -> '8' asRMDExpression) } asDictionary.
	self assert: (dicts at: 6) equals: { 
			('the p' asRMDExpression -> '2' asRMDExpression).
			('the q' asRMDExpression -> '7' asRMDExpression).
			('the r' asRMDExpression -> '8' asRMDExpression) } asDictionary
]

{ #category : #tests }
RMDVariabilityNodeTest >> testPrintOn [

	self
		assertPrintString: 'Variability.'
		convergeByParser: parser variability end.
	self
		assertPrintString: 'Variability with
	reproduce random 1
	10 runs each
	the p -> 1, 2
	the q, the r -> (3 [cm], 4[s]), (5 [m], 6[day]).'
		convergeByParser: parser variability end
]
