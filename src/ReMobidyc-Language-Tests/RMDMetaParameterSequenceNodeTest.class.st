Class {
	#name : #RMDMetaParameterSequenceNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDMetaParameterSequenceNodeTest >> testPrintOn [

	self
		assertPrintString: 'the p -> 1 [cm], 2 [m]'
		convergeByParser: parser metaParameterSequence end
]
