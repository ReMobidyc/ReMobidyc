Class {
	#name : #RMDPatchInitializerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPatchInitializerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser patchInitializer end
		parse:
			'5 x 6 of 10 [m] Patch with
	grass = uniform 1000 [kcal] to 5000 [kcal]'.
	replacement := Dictionary new
		at: 'grass' put: 'sugar';
		at: (parser expression end parse: '1000 [kcal]')
			put: (parser expression end parse: '2000 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser patchInitializer end
				parse:
					'5 x 6 of 10 [m] Patch with
	sugar = uniform 2000 [kcal] to 5000 [kcal]')
]

{ #category : #tests }
RMDPatchInitializerNodeTest >> testPrintOn [

	| node copy |
	node := parser patchInitializer end parse: '10 x 20 of 3[m] Patch with
		x = 1
		y = 2'.
	copy := parser patchInitializer end parse: node printString.
	self assert: copy equals: node.
	node := parser patchInitializer end parse: '10 x 20 of 3[m] Patch'.
	copy := parser patchInitializer end parse: node printString.
	self assert: copy equals: node
]
