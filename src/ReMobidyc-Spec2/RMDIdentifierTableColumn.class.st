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

	^ [ :item :stringOrText |
	  | string |
	  string := stringOrText asString trim.
	  item identifier: string.
	  extraAcceptAction ifNotNil: [
		  extraAcceptAction cull: item cull: string ] ]
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

{ #category : #defaults }
RMDIdentifierTableColumn >> defaultTextChangedAction [

	^ [ :item :string :widget |
	  | result |
	  result := RMDGrammar current identifier end parse:
		            string asString trimRight.
	  result isPetit2Failure ifTrue: [
		  widget text runs: (string asString asText
				   addAttribute: TextColor red
				   from: (result position + 1 min: string size max: 1)
				   to: string size;
				   yourself) runs.
		  widget textArea compose ] ]
]

{ #category : #accessing }
RMDIdentifierTableColumn >> validationBlock [

	^ validationBlock
]

{ #category : #accessing }
RMDIdentifierTableColumn >> validationBlock: aBlock [

	validationBlock := aBlock
]
