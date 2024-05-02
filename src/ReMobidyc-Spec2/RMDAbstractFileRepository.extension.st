Extension { #name : 'RMDAbstractFileRepository' }

{ #category : '*ReMobidyc-Spec2' }
RMDAbstractFileRepository >> edit [

	^ self editMenu openWithSpecAtPointer
]

{ #category : '*ReMobidyc-Spec2' }
RMDAbstractFileRepository >> editMenu [

	^ self subclassResponsibility
]

{ #category : '*ReMobidyc-Spec2' }
RMDAbstractFileRepository >> rename [

	(UIManager default request: 'New name' initialAnswer: name) 
		ifNotNil: [ :n | n trim ifNotEmpty: [ :newName | name := newName ] ]
]
