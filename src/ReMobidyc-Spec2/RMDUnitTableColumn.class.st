Class {
	#name : 'RMDUnitTableColumn',
	#superclass : 'RMDSyntaxTableColumn',
	#instVars : [
		'basicAcceptAction'
	],
	#category : 'ReMobidyc-Spec2-Columns',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Columns'
}

{ #category : 'defaults' }
RMDUnitTableColumn >> defaultAcceptAction [

	^ [ :item :stringOrText |
	  | string unit |
	  string := stringOrText asString trimRight.
	  unit := string
		          ifEmpty: [ RMDUnit noDimension ]
		          ifNotEmpty: [ RMDGrammar current unit end parse: string ].
	  unit isPetit2Success
		  ifTrue: [
			  item unit: unit.
			  extraAcceptAction ifNotNil: [ extraAcceptAction cull: item ] ]
		  ifFalse: [
			  self textWidgetContent: (string asText
					   addAttribute: TextColor red
					   from: (unit position + 1 min: string size max: 1)
					   to: string size;
					   yourself) ] ]
]

{ #category : 'defaults' }
RMDUnitTableColumn >> defaultColorAction [

	^ nil
]

{ #category : 'defaults' }
RMDUnitTableColumn >> defaultEvaluationBlock [

	^ [ :item |
	  | unit |
	  unit := item unit.
	  unit hasDimension
		  ifTrue: [ unit printString ]
		  ifFalse: [ '' ] ]
]

{ #category : 'defaults' }
RMDUnitTableColumn >> defaultTextChangedAction [

	^ [ :item :stringOrText :widget |
	  | string result |
	  string := stringOrText asString trimRight.
	  result := string
		            ifEmpty: [ RMDUnit noDimension ]
		            ifNotEmpty: [ :str |
		            RMDGrammar current unit end parse: str ].
	  result isPetit2Failure ifTrue: [
		  widget text runs: (string asText
				   addAttribute: TextColor red
				   from: (result position + 1 min: string size max: 1)
				   to: string size;
				   yourself) runs.
		  widget textArea compose ] ]
]
