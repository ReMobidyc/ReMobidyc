Class {
	#name : #RMDUnitTableColumn,
	#superclass : #RMDSyntaxTableColumn,
	#instVars : [
		'basicAcceptAction'
	],
	#category : #'ReMobidyc-Spec2-Columns'
}

{ #category : #defaults }
RMDUnitTableColumn >> defaultAcceptAction [

	^ [ :item :string |
	  | unit |
	  unit := string asString trimRight
		          ifEmpty: [ RMDUnit noDimension ]
		          ifNotEmpty: [ :str |
		          RMDGrammar current unit end parse: str ].
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

{ #category : #defaults }
RMDUnitTableColumn >> defaultColorAction [

	^ nil
]

{ #category : #defaults }
RMDUnitTableColumn >> defaultEvaluationBlock [

	^ [ :item |
	  | unit |
	  unit := item unit.
	  unit hasDimension
		  ifTrue: [ unit printString ]
		  ifFalse: [ '' ] ]
]
