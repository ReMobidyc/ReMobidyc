Class {
	#name : #RMDActionDebugger,
	#superclass : #RMDPresenter,
	#instVars : [
		'exception',
		'sourceText',
		'exceptionLabel',
		'subjectLabel',
		'actionLabel',
		'objectLabel',
		'variableList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDActionDebugger class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   hAlignCenter;
				   add: #exceptionLabel expand: false;
				   add: #subjectLabel expand: false;
				   add: ' ' expand: false;
				   add: #actionLabel expand: false;
				   add: ' ' expand: false;
				   add: #objectLabel expand: false;
				   yourself)
		  height: self inputTextHeight;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.7;
				   add: #sourceText;
				   add: #variableList;
				   yourself);
		  yourself
]

{ #category : #'instance creation' }
RMDActionDebugger class >> exception: aRMDSemanticError [

	^ self new
		  exception: aRMDSemanticError;
		  yourself
]

{ #category : #updating }
RMDActionDebugger >> contextChanged [

	self
		updateSubjectLabel;
		updateActionLabel;
		updateObjectLabel;
		updateSourceText;
		updateVariableList
]

{ #category : #accessing }
RMDActionDebugger >> exception [

	^ exception
]

{ #category : #accessing }
RMDActionDebugger >> exception: aRMDSemanticError [

	exception := aRMDSemanticError.
	self exceptionChanged
]

{ #category : #updating }
RMDActionDebugger >> exceptionChanged [

	self
		updateExceptionLabel;
		updateSubjectLabel;
		updateActionLabel;
		updateObjectLabel;
		updateSourceText;
		updateVariableList
]

{ #category : #initialization }
RMDActionDebugger >> initializePresenters [

	sourceText := (self newSourceWith:
			               RMDGrammar new actionDefinition end)
		              disable;
		              disableAutoTypechecking;
		              yourself.
	exceptionLabel := self newLabel
		                  label: '';
		                  yourself.
	subjectLabel := self newLabel
		                label: 'N/A';
		                yourself.
	actionLabel := self newLabel
		               label: 'N/A';
		               yourself.
	objectLabel := self newLabel
		               label: 'N/A';
		               yourself.
	variableList := self newTable
		                beSingleSelection;
		                beResizable;
		                hideColumnHeaders;
		                addColumn:
			                (SpStringTableColumn
				                 title: 'variable'
				                 evaluated: [ :item | item key ]);
		                addColumn:
			                (SpStringTableColumn
				                 title: 'value'
				                 evaluated: [ :item | item value ]);
		                yourself
]

{ #category : #accessing }
RMDActionDebugger >> interpreter [

	^ exception interpreter
]

{ #category : #updating }
RMDActionDebugger >> interpreterChanged [

	self
		updateSubjectLabel;
		updateActionLabel;
		updateObjectLabel;
		updateSourceText;
		updateVariableList
]

{ #category : #updating }
RMDActionDebugger >> updateActionLabel [

	actionLabel ifNotNil: [
		actionLabel label: (self interpreter
				 ifNotNil: [ :interpreter |
					 interpreter context action ifNotNil: #identifier ifNil: [ '?' ] ]
				 ifNil: [ 'N/A' ]) ]
]

{ #category : #updating }
RMDActionDebugger >> updateExceptionLabel [

	exceptionLabel ifNotNil: [ 
		exceptionLabel label:
			(exception
				 ifNotNil: [ exception messageText , ' in ' ]
				 ifNil: [ '' ]) ]
]

{ #category : #updating }
RMDActionDebugger >> updateObjectLabel [

	objectLabel ifNotNil: [
		objectLabel label: (self interpreter
				 ifNotNil: [ :interpreter |
					 interpreter context objectDefinition
						 ifNotNil: [ :agent |
							 agent name , '(' , interpreter context object printString
							 , ')' ]
						 ifNil: [ '' ] ]
				 ifNil: [ 'N/A' ]) ]
]

{ #category : #updating }
RMDActionDebugger >> updateSourceText [

	sourceText ifNotNil: [
		sourceText
			highlights: (exception
					 ifNil: [ #(  ) ]
					 ifNotNil: [ { exception originalSemanticError node } ]);
			syntaxNode: self interpreter context action ]
]

{ #category : #updating }
RMDActionDebugger >> updateSubjectLabel [

	subjectLabel ifNotNil: [
		subjectLabel label: (self interpreter
				 ifNotNil: [ :interpreter |
					 interpreter context subjectDefinition
						 ifNotNil: [ :agent |
							 agent name , '(' , interpreter context subject printString
							 , ')' ]
						 ifNil: [ '' ] ]
				 ifNil: [ 'N/A' ]) ]
]

{ #category : #updating }
RMDActionDebugger >> updateVariableList [

	variableList items: (Array streamContents: [ :stream |
			 self interpreter ifNotNil: [ :interpreter |
				 interpreter context subjectDefinition ifNotNil: [ :subjectDef |
					 subjectDef attributeDeclarations do: [ :attributeDecl |
						 stream nextPut: 'my ' , attributeDecl identifier
							 -> (interpreter my: attributeDecl identifier) ] ].
				 interpreter context objectDefinition ifNotNil: [ :objectDef |
					 objectDef attributeDeclarations do: [ :attributeDecl |
						 stream nextPut:
							 objectDef agentName uncapitalized , '''s '
							 , attributeDecl identifier
							 -> (interpreter objects: attributeDecl identifier) ] ].
				 interpreter simulationModel patchDefinition ifNotNil: [ :patchDef |
					 patchDef attributeDeclarations do: [ :attributeDecl |
						 stream nextPut: 'here''s ' , attributeDecl identifier
							 -> (interpreter heres: attributeDecl identifier) ] ].
				 interpreter simulationModel worldDefinition ifNotNil: [ :worldDef |
					 worldDef attributeDeclarations do: [ :attributeDecl |
						 stream nextPut: 'world''s ' , attributeDecl identifier
							 -> (interpreter worlds: attributeDecl identifier) ] ].
				 interpreter context action ifNotNil: [ :action |
					 action utilityDefinitions do: [ :utilityDef |
						 | utilityName utilityValue |
						 utilityName := utilityDef variable identifier.
						 utilityValue := (interpreter context
							                  utilityAt: utilityName
							                  ifAbsent: [ nil ]) ifNotNil: [ :value |
							                 value isNumber
								                 ifTrue: [ value ]
								                 ifFalse: [
								                 '{ ' , value definitionBody asString , ' }' ] ].
						 stream nextPut:
							 utilityName
							 -> (utilityValue ifNotNil: #asString ifNil: [ 'N/A' ]) ] ] ] ])
]
