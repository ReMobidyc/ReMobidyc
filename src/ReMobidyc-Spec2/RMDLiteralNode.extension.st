Extension { #name : 'RMDLiteralNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDLiteralNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode literal: literal unit: (unit hasDimension
			   ifTrue: [ '[' , unit printString , ']' ]
			   ifFalse: [ '' ])
]
