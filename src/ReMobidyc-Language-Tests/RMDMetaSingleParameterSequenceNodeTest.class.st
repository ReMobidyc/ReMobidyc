Class {
	#name : #RMDMetaSingleParameterSequenceNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDMetaSingleParameterSequenceNodeTest >> testPrintOn [

	self
		assertPrintString: 'the p -> 1 [cm], 2 [m]'
		convergeByParser: parser metaSingleParameterSequence end;
		assertPrintString: 'the p -> 1, 2'
		convergeByParser: parser metaSingleParameterSequence end;
		assertPrintString: 'the p -> 1 [cm]'
		convergeByParser: parser metaSingleParameterSequence end
]
