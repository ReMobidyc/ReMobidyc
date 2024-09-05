Class {
	#name : #RMDPossessionalAgentDropListTableColumn,
	#superclass : #SpDropListTableColumn,
	#instVars : [
		'subjectBlock',
		'objectBlock',
		'directiveBlock',
		'initialSelectionBlock'
	],
	#category : #'ReMobidyc-Spec2-Columns'
}

{ #category : #examples }
RMDPossessionalAgentDropListTableColumn class >> example [

	^ SpTablePresenter new
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn:
			((SpDropListTableColumn title: 'Value' evaluated: [ {true . false} ])
				width: 50;
				yourself);
		items: self class environment allClasses;
		beResizable;
		open
]

{ #category : #visiting }
RMDPossessionalAgentDropListTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitRMDPossessionalAgentDropListColumn: self
]

{ #category : #defaults }
RMDPossessionalAgentDropListTableColumn >> defaultDisplay [

	^ [ :agent | self displayAgent: agent ]
]

{ #category : #defaults }
RMDPossessionalAgentDropListTableColumn >> defaultEvaluation [

	^ [ self possibleAgents ]
]

{ #category : #defaults }
RMDPossessionalAgentDropListTableColumn >> defaultInitialSelectionBlock [

	^ [ :attributeDefinition | attributeDefinition variable agent ]
]

{ #category : #defaults }
RMDPossessionalAgentDropListTableColumn >> defaultSelectedItemChangedAction [

	^ [ :attributeDefinition :agent |
	  attributeDefinition variable agent: agent ]
]

{ #category : #defaults }
RMDPossessionalAgentDropListTableColumn >> defaultStartWithSelection [

	^ true
]

{ #category : #defaults }
RMDPossessionalAgentDropListTableColumn >> defaultWidth [

	^ 80
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> directiveBlock [

	^ directiveBlock
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> directiveBlock: aBlock [

	directiveBlock := aBlock
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> displayAgent: agent [

	agent ifNil: [ ^ 'my' ].
	agent = #world ifTrue: [ ^ 'world''s' ].
	agent = #here ifTrue: [ ^ 'here''s' ].
	agent = #new ifTrue: [ ^ 'new' ].
	agent = #the ifTrue: [ ^ 'the' ].
	^ agent uncapitalized , '''s'
]

{ #category : #controlling }
RMDPossessionalAgentDropListTableColumn >> ifNewDirective: aBlock [

	(directiveBlock ifNotNil: #value) ifNotNil: [ :lifeDirectives |
		(lifeDirectives contains: #hasNewAgents) ifTrue: aBlock ]
]

{ #category : #controlling }
RMDPossessionalAgentDropListTableColumn >> ifObject: aBlock [

	^ (objectBlock ifNotNil: #value) ifNotNil: aBlock
]

{ #category : #controlling }
RMDPossessionalAgentDropListTableColumn >> ifWorldSubject: worldBlock ifPatchSubject: patchBlock ifAnimatSubject: animatBlock [

	self subject ifNotNil: [ :subject |
		subject = #World ifTrue: [ ^ worldBlock value ].
		subject = #Patch ifTrue: [ ^ patchBlock value ] ].
	^ animatBlock value
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> initialSelection: aRMDAttributeDefinitionNode [

	^ initialSelectionBlock ifNotNil: [
		  initialSelectionBlock cull: aRMDAttributeDefinitionNode ]
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> initialSelectionBlock [

	^ initialSelectionBlock
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> initialSelectionBlock: aBlock [

	initialSelectionBlock := aBlock
]

{ #category : #initialization }
RMDPossessionalAgentDropListTableColumn >> initialize [

	super initialize.
	evaluation := self defaultEvaluation.
	display := self defaultDisplay.
	self startWithSelection: self defaultInitialSelectionBlock.
	selectedItemChangedAction := self defaultSelectedItemChangedAction.
	self width: self defaultWidth
]

{ #category : #testing }
RMDPossessionalAgentDropListTableColumn >> isAnimatSubject [

	^ (self isWorldSubject or: [ self isPatchSubject ]) not
]

{ #category : #testing }
RMDPossessionalAgentDropListTableColumn >> isPatchSubject [

	^ (subjectBlock ifNotNil: #value) = 'Patch'
]

{ #category : #testing }
RMDPossessionalAgentDropListTableColumn >> isWorldSubject [

	^ (subjectBlock ifNotNil: #value) = 'World'
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> object [

	^ objectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> objectBlock [

	^ objectBlock
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> objectBlock: aBlock [

	objectBlock := aBlock
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> possibleAgents [

	^ Array streamContents: [ :stream |
		  stream nextPut: nil.
		  self
			  ifWorldSubject: [  ]
			  ifPatchSubject: [ stream nextPut: #world ]
			  ifAnimatSubject: [
				  stream
					  nextPut: #world;
					  nextPut: #here ].
		  self ifObject: [ :object | stream nextPut: object uncapitalized ].
		  self ifNewDirective: [ stream nextPut: #new ].
		  stream nextPut: #the ]
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> startWithSelection [

	initialSelectionBlock ifNil: [
		initialSelectionBlock := self defaultInitialSelectionBlock ].
	super startWithSelection
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> startWithSelection: aBlock [

	initialSelectionBlock ifNil: [ initialSelectionBlock := aBlock ].
	super startWithSelection
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> startWithoutSelection [

	initialSelectionBlock := nil.
	super startWithoutSelection
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> subject [

	^ subjectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> subjectBlock [

	^ subjectBlock
]

{ #category : #accessing }
RMDPossessionalAgentDropListTableColumn >> subjectBlock: aBlock [

	subjectBlock := aBlock
]
