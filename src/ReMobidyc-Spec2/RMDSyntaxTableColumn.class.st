Class {
	#name : 'RMDSyntaxTableColumn',
	#superclass : 'SpStringTableColumn',
	#instVars : [
		'textChangedAction',
		'extraAcceptAction'
	],
	#category : 'ReMobidyc-Spec2-Columns',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Columns'
}

{ #category : 'visiting' }
RMDSyntaxTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitRMDSyntaxColumn: self
]

{ #category : 'defaults' }
RMDSyntaxTableColumn >> defaultAcceptAction [

	^ self subclassResponsibility
]

{ #category : 'defaults' }
RMDSyntaxTableColumn >> defaultColorAction [

	^ self subclassResponsibility
]

{ #category : 'defaults' }
RMDSyntaxTableColumn >> defaultEvaluationBlock [

	^ self subclassResponsibility
]

{ #category : 'defaults' }
RMDSyntaxTableColumn >> defaultTextChangedAction [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDSyntaxTableColumn >> extraAcceptAction [

	^ extraAcceptAction
]

{ #category : 'accessing' }
RMDSyntaxTableColumn >> extraAcceptAction: aBlock [

	extraAcceptAction := aBlock
]

{ #category : 'initialization' }
RMDSyntaxTableColumn >> initialize [

	super initialize.
	evaluation := self defaultEvaluationBlock.
	textChangedAction := self defaultTextChangedAction.
	acceptAction := self defaultAcceptAction.
	colorAction := self defaultColorAction.
	self beEditable
]

{ #category : 'accessing' }
RMDSyntaxTableColumn >> textChangedAction [

	^ textChangedAction
]

{ #category : 'accessing' }
RMDSyntaxTableColumn >> textChangedAction: aBlock [

	textChangedAction := aBlock
]

{ #category : 'private' }
RMDSyntaxTableColumn >> textWidgetContent: aText [

	| context presenter |
	context := thisContext.
	presenter := nil.
	[ presenter class = SpTextInputFieldPresenter ] whileFalse: [
		context := context sender.
		context ifNil: [ ^ nil ].
		presenter := context receiver ].
	presenter withAdapterDo: [ :adapter |
		adapter widgetDo: [ :widget |
			widget text runs: aText runs.
			widget textArea compose ] ]
]
