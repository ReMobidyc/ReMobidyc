Class {
	#name : #RMDDebugger,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
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
RMDDebugger class >> defaultLayout [

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
RMDDebugger class >> on: aRMDInterpreter exception: aRMDSemanticError [

	^ self new
		  interpreter: aRMDInterpreter;
		  exception: aRMDSemanticError;
		  yourself
]

{ #category : #updating }
RMDDebugger >> contextChanged [

	self
		updateSubjectLabel;
		updateActionLabel;
		updateObjectLabel;
		updateSourceText;
		updateVariableList
]

{ #category : #accessing }
RMDDebugger >> exception [

	^ exception
]

{ #category : #accessing }
RMDDebugger >> exception: aRMDSemanticError [

	exception := aRMDSemanticError.
	self exceptionChanged
]

{ #category : #updating }
RMDDebugger >> exceptionChanged [

	self
		updateExceptionLabel;
		updateSourceText
]

{ #category : #initialization }
RMDDebugger >> initializePresenters [

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
RMDDebugger >> interpreter [

	^ interpreter
]

{ #category : #accessing }
RMDDebugger >> interpreter: aRMDInterpreter [

	interpreter := aRMDInterpreter.
	self interpreterChanged
]

{ #category : #updating }
RMDDebugger >> interpreterChanged [

	self
		updateSubjectLabel;
		updateActionLabel;
		updateObjectLabel;
		updateSourceText;
		updateVariableList
]

{ #category : #updating }
RMDDebugger >> updateActionLabel [

	actionLabel ifNotNil: [ 
		actionLabel label: (interpreter
				 ifNotNil: [ 
				 interpreter context action ifNotNil: #identifier ifNil: [ '?' ] ]
				 ifNil: [ 'N/A' ]) ]
]

{ #category : #updating }
RMDDebugger >> updateExceptionLabel [

	exceptionLabel ifNotNil: [ 
		exceptionLabel label:
			(exception
				 ifNotNil: [ exception messageText , ' in ' ]
				 ifNil: [ '' ]) ]
]

{ #category : #updating }
RMDDebugger >> updateObjectLabel [

	objectLabel ifNotNil: [ 
		objectLabel label: (interpreter
				 ifNotNil: [ 
					 interpreter context objectDefinition
						 ifNotNil: [ :agent | 
							 agent name , '(' , interpreter context object printString
							 , ')' ]
						 ifNil: [ '' ] ]
				 ifNil: [ 'N/A' ]) ]
]

{ #category : #updating }
RMDDebugger >> updateSourceText [

	sourceText ifNotNil: [ 
		sourceText
			highlights:
				(exception ifNil: [ #(  ) ] ifNotNil: [ { exception node } ]);
			syntaxNode: interpreter context action ]
]

{ #category : #updating }
RMDDebugger >> updateSubjectLabel [

	subjectLabel ifNotNil: [ 
		subjectLabel label: (interpreter
				 ifNotNil: [ 
					 interpreter context subjectDefinition
						 ifNotNil: [ :agent | 
							 agent name , '(' , interpreter context subject printString
							 , ')' ]
						 ifNil: [ '' ] ]
				 ifNil: [ 'N/A' ]) ]
]

{ #category : #updating }
RMDDebugger >> updateVariableList [

	variableList items: (Array streamContents: [ :stream | 
			 interpreter ifNotNil: [ 
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
