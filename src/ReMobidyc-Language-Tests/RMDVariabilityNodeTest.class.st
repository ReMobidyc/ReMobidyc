Class {
	#name : #RMDVariabilityNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDVariabilityNodeTest >> testDictionariesDo [

	self
		assert: (Array streamContents: [ :stream | 
				 (parser variability end parse: 'Variability with
	reproduce random 1
	the p -> 1, 2
	the q, the r -> (3, 4), (5, 6), (7, 8).') dictionariesDo: [ :dict | 
					 stream nextPut: dict ] ])
		with: [ :dicts | 
			self assert: dicts size equals: 6.
			self assert: (dicts includes: { 
						 ('the p' asRMDExpression -> '1' asRMDExpression).
						 ('the q' asRMDExpression -> '3' asRMDExpression).
						 ('the r' asRMDExpression -> '4' asRMDExpression) } asDictionary).
			self assert: (dicts includes: { 
						 ('the p' asRMDExpression -> '2' asRMDExpression).
						 ('the q' asRMDExpression -> '3' asRMDExpression).
						 ('the r' asRMDExpression -> '4' asRMDExpression) } asDictionary).
			self assert: (dicts includes: { 
						 ('the p' asRMDExpression -> '1' asRMDExpression).
						 ('the q' asRMDExpression -> '5' asRMDExpression).
						 ('the r' asRMDExpression -> '6' asRMDExpression) } asDictionary).
			self assert: (dicts includes: { 
						 ('the p' asRMDExpression -> '2' asRMDExpression).
						 ('the q' asRMDExpression -> '5' asRMDExpression).
						 ('the r' asRMDExpression -> '6' asRMDExpression) } asDictionary).
			self assert: (dicts includes: { 
						 ('the p' asRMDExpression -> '1' asRMDExpression).
						 ('the q' asRMDExpression -> '7' asRMDExpression).
						 ('the r' asRMDExpression -> '8' asRMDExpression) } asDictionary).
			self assert: (dicts includes: { 
						 ('the p' asRMDExpression -> '2' asRMDExpression).
						 ('the q' asRMDExpression -> '7' asRMDExpression).
						 ('the r' asRMDExpression -> '8' asRMDExpression) } asDictionary) ].
	self
		assert: (Array streamContents: [ :stream | 
				 (parser variability end parse: 'Variability.') dictionariesDo: [ 
					 :dict | stream nextPut: dict ] ])
		with: [ :dicts | self assert: dicts equals: { Dictionary new } ]
]

{ #category : #tests }
RMDVariabilityNodeTest >> testPrintOn [

	self
		assertPrintString: 'Variability.'
		convergeByParser: parser variability end.
	self
		assertPrintString: 'Variability with
	10 runs each
	the p -> 1, 2
	the q, the r -> (3 [cm], 4[s]), (5 [m], 6[day]).'
		convergeByParser: parser variability end.
	self
		assertPrintString: 'Variability with
	reproduce random 1
	the p -> 1, 2
	the q, the r -> (3 [cm], 4[s]), (5 [m], 6[day]).'
		convergeByParser: parser variability end
]
