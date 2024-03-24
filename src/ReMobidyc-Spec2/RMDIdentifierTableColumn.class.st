Class {
	#name : #RMDIdentifierTableColumn,
	#superclass : #RMDSyntaxTableColumn,
	#instVars : [
		'validationBlock'
	],
	#category : #'ReMobidyc-Spec2-Columns'
}

{ #category : #defaults }
RMDIdentifierTableColumn >> defaultAcceptAction [

	^ [ :item :string |
	  item identifier: string asString trim.
	  extraAcceptAction ifNotNil: [
		  extraAcceptAction cull: item cull: string asString trim ] ]
]

{ #category : #defaults }
RMDIdentifierTableColumn >> defaultColorAction [

	^ [ :item |
	  item identifier isCorrectRMDIdentifier
		  ifTrue: [
			  (validationBlock isNil or: [ (validationBlock cull: item) = true ])
				  ifTrue: [ Color black ]
				  ifFalse: [ Color yellow muchDarker ] ]
		  ifFalse: [ Color red ] ]
]

{ #category : #defaults }
RMDIdentifierTableColumn >> defaultEvaluationBlock [

	^ [ :item | item identifier ifEmpty: [ '-' ] ]
]

{ #category : #accessing }
RMDIdentifierTableColumn >> validationBlock [

	^ validationBlock
]

{ #category : #accessing }
RMDIdentifierTableColumn >> validationBlock: aBlock [

	validationBlock := aBlock
]
