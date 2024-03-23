Class {
	#name : #RMDExpressionTableColumn,
	#superclass : #RMDSyntaxTableColumn,
	#instVars : [
		'basicEvaluation',
		'basicAcceptAction',
		'unitBlock',
		'subjectBlock',
		'objectBlock',
		'utilitiesBlock',
		'simulationModelBlock'
	],
	#category : #'ReMobidyc-Spec2-Columns'
}

{ #category : #defaults }
RMDExpressionTableColumn >> defaultAcceptAction [

	^ [ :item :string |
	  | expression |
	  expression := RMDGrammar current expression end parse:
		                string asString trimRight.
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

{ #category : #defaults }
RMDExpressionTableColumn >> defaultColorAction [

	^ nil
]

{ #category : #defaults }
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
						  utilities: self utilities
						  in: self simulationModel ]
				  ifNil: [ '' ] ]
		  ifNil: [ '' ] ]
]

{ #category : #accessing }
RMDExpressionTableColumn >> evaluated: aBlock [

	basicEvaluation := aBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> object [

	^ objectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDExpressionTableColumn >> objectBlock [

	^ objectBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> objectBlock: aBlock [

	objectBlock := aBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> onAcceptEdition: aBlock [

	basicAcceptAction := aBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> simulationModel [

	^ simulationModelBlock ifNotNil: #value
]

{ #category : #accessing }
RMDExpressionTableColumn >> simulationModelBlock [

	^ simulationModelBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> simulationModelBlock: aBlock [

	simulationModelBlock := aBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> subject [

	^ subjectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDExpressionTableColumn >> subjectBlock [

	^ subjectBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> subjectBlock: aBlock [

	subjectBlock := aBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> unitBlock [

	^ unitBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> unitBlock: aBlock [

	unitBlock := aBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> utilities [

	^ utilitiesBlock ifNotNil: #value
]

{ #category : #accessing }
RMDExpressionTableColumn >> utilitiesBlock [

	^ utilitiesBlock
]

{ #category : #accessing }
RMDExpressionTableColumn >> utilitiesBlock: aBlock [

	utilitiesBlock := aBlock
]
