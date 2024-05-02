Class {
	#name : 'RMDExpressionTableColumn',
	#superclass : 'RMDSyntaxTableColumn',
	#instVars : [
		'basicEvaluation',
		'basicAcceptAction',
		'unitBlock',
		'subjectBlock',
		'objectBlock',
		'utilitiesBlock',
		'simulationModelBlock',
		'permitsUnresolvedAttributeReference'
	],
	#category : 'ReMobidyc-Spec2-Columns',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Columns'
}

{ #category : 'defaults' }
RMDExpressionTableColumn >> defaultAcceptAction [

	^ [ :item :stringOrText |
	  | string expression |
	  string := stringOrText asString trimRight.
	  expression := RMDGrammar current expression end parse:
		                string trimRight.
	  expression isPetit2Success
		  ifTrue: [
			  basicAcceptAction ifNotNil: [
				  basicAcceptAction cull: item cull: expression ] ]
		  ifFalse: [
			  self textWidgetContent: (string asText
					   addAttribute: TextColor red
					   from: (expression position + 1 min: string size max: 1)
					   to: string size;
					   yourself) ] ]
]

{ #category : 'defaults' }
RMDExpressionTableColumn >> defaultColorAction [

	^ nil
]

{ #category : 'defaults' }
RMDExpressionTableColumn >> defaultEvaluationBlock [

	^ [ :item |
	  basicEvaluation
		  ifNotNil: [
			  (basicEvaluation cull: item)
				  ifNotNil: [ :expr |
					  expr
						  highlightedSourceTyped:
							  ((unitBlock ifNotNil: [ unitBlock cull: item ])
								   ifNotNil: [ :unit | RMDType unit: unit ]
								   ifNil: [ RMDType any ])
						  subject: self subject
						  object: self object
						  utilities: self utilities
						  in: self simulationModel typechecker
						  permitUnresolvedAttributeReference: self permitsUnresolvedAttributeReference ]
				  ifNil: [ '' ] ]
		  ifNil: [ '' ] ]
]

{ #category : 'defaults' }
RMDExpressionTableColumn >> defaultTextChangedAction [

	^ [ :item :string :widget |
	  | result |
	  result := RMDGrammar current expression end parse:
		            string asString trimRight.
	  result isPetit2Failure ifTrue: [
		  widget text runs: (string asString asText
				   addAttribute: TextColor red
				   from: (result position + 1 min: string size max: 1)
				   to: string size;
				   yourself) runs.
		  widget textArea compose ] ]
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> evaluated: aBlock [

	basicEvaluation := aBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> object [

	^ objectBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> objectBlock [

	^ objectBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> objectBlock: aBlock [

	objectBlock := aBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> onAcceptEdition: aBlock [

	basicAcceptAction := aBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> permitUnresolvedAttributeReference [

	permitsUnresolvedAttributeReference := true
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> permitsUnresolvedAttributeReference [

	^ permitsUnresolvedAttributeReference = true
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> permitsUnresolvedAttributeReference: aBool [

	permitsUnresolvedAttributeReference := aBool = true
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> simulationModel [

	^ simulationModelBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> simulationModelBlock [

	^ simulationModelBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> simulationModelBlock: aBlock [

	simulationModelBlock := aBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> subject [

	^ subjectBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> subjectBlock [

	^ subjectBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> subjectBlock: aBlock [

	subjectBlock := aBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> unitBlock [

	^ unitBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> unitBlock: aBlock [

	unitBlock := aBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> utilities [

	^ utilitiesBlock ifNotNil: #value
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> utilitiesBlock [

	^ utilitiesBlock
]

{ #category : 'accessing' }
RMDExpressionTableColumn >> utilitiesBlock: aBlock [

	utilitiesBlock := aBlock
]
