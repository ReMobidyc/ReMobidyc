Extension { #name : #AbstractFileReference }

{ #category : #'*ReMobidyc-Interpreter' }
AbstractFileReference >> lfWriteStreamDo: aBlock [

	self writeStreamDo: [ :stream | 
		aBlock value: ((ZnNewLineWriterStream on: stream)
				 forLf;
				 yourself) ]
]
