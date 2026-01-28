Class {
	#name : 'RMDMetaParameterSetSequenceNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDMetaParameterSetSequenceNodeTest >> testPrintOn [

	self
		assertPrintString: 'the p, the q -> (1 [cm], 2 [m]), (3[km], 4[ft])'
		convergeByParser: parser metaParameterSetSequence end;
		assertPrintString: 'the p, the q -> 
				(1, 2), 
				(3, 4)'
		convergeByParser: parser metaParameterSetSequence end;
		assertPrintString: 'the p -> (1 [cm])'
		convergeByParser: parser metaParameterSetSequence end
]
