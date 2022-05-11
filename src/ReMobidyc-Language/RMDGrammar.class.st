Class {
	#name : #RMDGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'definition',
		'expression',
		'identifier',
		'agentIdentifier',
		'agentReference',
		'condition',
		'guardedChoice',
		'literal'
	],
	#classVars : [
		'Builtins',
		'Keywords'
	],
	#category : #'ReMobidyc-Language-Parser'
}

{ #category : #'accessing method dictionary' }
RMDGrammar class >> addSelectorSilently: selector withMethod: compiledMethod [
	Keywords := nil.
	Builtins := nil.
	^ super addSelectorSilently: selector withMethod: compiledMethod
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinition [

	^ self actionDefinitionHeaderLine , self whenClause optional
	  , self withClause optional
	  , self actionDefinitionAttributePart optional
	  , self actionDefinitionUtilityPart optional
	  , '.' asPParser trimBlanks , #newline asPParser trimBlanks optional
	  ==> [ :array | 
		  self actionDefinitionNodeClass
			  name: array first first
			  object: array first second
			  guard: array second
			  lifeDirectives: (array third ifNil: [ Array new ])
			  attributeDefinitions: (array fourth ifNil: [ Array new ])
			  utilityDefinitions: (array fifth ifNil: [ Array new ]) ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinitionAttributePart [

	^ #newline asPParser trimBlanks optional
	  , (self attributeDefinition onlySeparatedBy:
			   #newline asPParser trimBlanks) ==> #second
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinitionHeaderLine [

	^ 'to' asPParser trimBlanks , identifier trimBlanks
	  , agentIdentifier optional , 'is' asPParser trimBlanks
	  ==> [ :array | 
		  { 
			  array second.
			  array third } ]
]

{ #category : #'class access' }
RMDGrammar >> actionDefinitionNodeClass [
	^ RMDActionDefinitionNode 
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinitionUtilityPart [

	^ #newline asPParser trimBlanks , 'where' asPParser trimBlanks
	  , #newline asPParser trimBlanks
	  ,
	  (self utilityDefinition onlySeparatedBy:
		   #newline asPParser trimBlanks)
	  , #newline asPParser trimBlanks optional ==> #fourth
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionIdentifier [

	^ identifier
]

{ #category : #'class access' }
RMDGrammar >> additionNodeClass [
	^ RMDAdditionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> agentDefinition [

	^ self worldDefinition / self patchDefinition / self animatDefinition
]

{ #category : #'parsers-atoms' }
RMDGrammar >> agentDirective [

	^ self directionOfGradientDirective / self distanceDirective
	  / self directionDirective / self timeDirective
]

{ #category : #'class access' }
RMDGrammar >> agentDirectiveNodeClass [
	^ RMDAgentDirectiveNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> agentIdentifier [
	^ (#letter asPParser
		, (#letter asPParser / #digit asPParser / $_ asPParser) star)
		flatten trimBlanks
		==> [ :name | 
			(self keywords includes: name)
				ifTrue: [ PP2Failure message: name , ' is a reserved word.' ]
				ifFalse: [ name first isUppercase
						ifTrue: [ name ]
						ifFalse: [ PP2Failure
								message: 'An agent name must start with a uppercase letter.' ] ] ]
]

{ #category : #'parsers-atoms' }
RMDGrammar >> agentReference [

	^ ('my' asPParser , #space asPParser) trimBlanks ==> [ :str | nil ]
	  /
	  (('new' asPParser , #space asPParser) trimBlanks
	   ==> [ :str | #new ])
	  / (identifier , '''s ' asPParser trimBlanks ==> #first)
]

{ #category : #units }
RMDGrammar >> allUnits [
	^ Dictionary new
		addAll: self timeUnits;
		addAll: self lengthUnits;
		addAll: self weightUnits;
		addAll: self energyUnits;
		addAll: self temperatureUnits;
		yourself
]

{ #category : #'parsers-definitions' }
RMDGrammar >> animatAttributePart [
	^ ('with' asPParser trimBlanks , #newline asPParser trimBlanks
		,
			(self attributeDeclaration
				onlySeparatedBy: #newline asPParser trimBlanks)
		, #newline asPParser trimBlanks optional) ==> #third
]

{ #category : #'parsers-definitions' }
RMDGrammar >> animatDefinition [
	^ (self animatHeader , self animatAttributePart optional
		, '.' asPParser trimBlanks , #newline asPParser trimBlanks optional)
		==> [ :quad | 
			self animatDefinitionNodeClass
				identifier: quad first
				attributeDeclarations: (quad second ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> animatDefinitionNodeClass [
	^ RMDAnimatDefinitionNode
]

{ #category : #'parsers-visualizations' }
RMDGrammar >> animatDotRenderer [

	^ self agentIdentifier , '->' asPParser trimBlanks , self nat
	  , ('@' asPParser trimBlanks , self nat ==> #second) optional
	  , 'pixels' asPParser trimBlanks , self color
	  , 'dot' asPParser trimBlanks , '.' asPParser trimBlanks
	  , #newline asPParser trimBlanks optional ==> [ :array | 
	  RMDAnimatDotRenderer
		  on: (array at: 1)
		  diameter: ((array at: 4)
				   ifNotNil: [ :y | (array at: 3) @ y ]
				   ifNil: [ array at: 3 ])
		  color: (array at: 6) ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> animatHeader [

	^ agentIdentifier , 'is' asPParser trimBlanks
	  , 'Animat' asPParser trimBlanks ==> #first
]

{ #category : #'parsers-definitions' }
RMDGrammar >> animatInitializer [

	^ #digit asPParser plus flatten trimBlanks , agentIdentifier
	  , ('with' asPParser trimBlanks , #newline asPParser trimBlanks
		   , (self attributeInitializer onlySeparatedBy:
				    #newline asPParser trimBlanks) ==> #third) optional
	  ==> [ :triple | 
		  self animatInitializerNodeClass
			  population: triple first asInteger
			  animat: triple second
			  attributeInitializers: (triple third ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> animatInitializerNodeClass [
	^ RMDAnimatInitializerNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> apply [
	^ (identifier , $( asPParser trimBlanks
		, (expression onlySeparatedBy: $, asPParser trimBlanks)
		, $) asPParser trimBlanks)
		==>
			[ :quad | self applyNodeClass function: quad first expressions: quad third ]
]

{ #category : #'class access' }
RMDGrammar >> applyNodeClass [
	^ RMDApplyNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> assignableAttributeVariable [

	^ agentReference , identifier ==> [ :pair | 
	  self assignableAttributeVariableNodeClass
		  identifier: pair second
		  agent: pair first ] / (self the , identifier ==> [ :pair | 
	   self assignableAttributeVariableNodeClass attributeVariable:
		   (self placeholderNodeClass identifier: pair second) ])
]

{ #category : #'class access' }
RMDGrammar >> assignableAttributeVariableNodeClass [
	^ RMDAssignableAttributeVariableNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> assignableDeltaAttributeVariable [

	^ agentReference , self delta , identifier ==> [ :triple | 
	  self assignableDeltaAttributeVariableNodeClass
		  identifier: triple third
		  agent: triple first ]
	  / (self the , self delta , identifier ==> [ :triple | 
		   self assignableDeltaAttributeVariableNodeClass attributeVariable:
			   (self placeholderNodeClass identifier: triple third) ])
]

{ #category : #'class access' }
RMDGrammar >> assignableDeltaAttributeVariableNodeClass [
	^ RMDAssignableDeltaAttributeVariableNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> assignableDifferentialAttributeVariable [

	^ agentReference , self differential , identifier ==> [ :triple | 
	  self assignableDifferentialAttributeVariableNodeClass
		  identifier: triple third
		  agent: triple first ]
	  / (self the , self differential , identifier ==> [ :triple | 
		   self assignableDifferentialAttributeVariableNodeClass 
			   attributeVariable:
			   (self placeholderNodeClass identifier: triple third) ])
]

{ #category : #'class access' }
RMDGrammar >> assignableDifferentialAttributeVariableNodeClass [
	^ RMDAssignableDifferentialAttributeVariableNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> assignableNewAttributeVariable [

	^ 'new' asPParser , #blank asPParser plus , identifier
	  ==> [ :triple | 
		  self assignableAttributeVariableNodeClass attributeVariable:
			  (self newAttributeVariableNodeClass identifier: triple third) ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> assignableVariable [

	^ self assignableDifferentialAttributeVariable
	  / self assignableDeltaAttributeVariable
	  / self assignableAttributeVariable
]

{ #category : #'parsers-definitions' }
RMDGrammar >> attributeBind [

	^ self placeholder , '->' asPParser trimBlanks , expression
	  /
	  (self newDirective , '->' asPParser trimBlanks , self newDirective)
	  ==> [ :triple | 
		  self attributeBindNodeClass
			  placeholder: triple first
			  replacement: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> attributeBindNodeClass [
	^ RMDAttributeBindNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> attributeDeclaration [
	^ (identifier , self type)
		==> [ :pair | 
			self attributeDeclarationNodeClass
				identifier: pair first
				unit: pair second ]
]

{ #category : #'class access' }
RMDGrammar >> attributeDeclarationNodeClass [
	^ RMDAttributeDeclarationNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> attributeDefinition [

	^ self assignableVariable , $' asPParser trimBlanks
	  , '=' asPParser trimBlanks , guardedChoice ==> [ :quad | 
	  self attributeDefinitionNodeClass
		  variable: quad first
		  expression: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> attributeDefinitionNodeClass [
	^ RMDAttributeDefinitionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> attributeInitializer [
	^ (identifier , '=' asPParser trimBlanks , expression)
		==> [ :triple | 
			self attributeInitializerNodeClass
				identifier: triple first
				expression: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> attributeInitializerNodeClass [
	^ RMDAttributeInitializerNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> attributeVariable [
	^ (agentReference , identifier)
		==> [ :pair | 
			self attributeVariableNodeClass
				identifier: pair second
				agent: pair first ]
]

{ #category : #'class access' }
RMDGrammar >> attributeVariableNodeClass [
	^ RMDAttributeVariableNode
]

{ #category : #'parsers-visualizations' }
RMDGrammar >> backgroundColorRenderer [

	^ 'World' asPParser trimBlanks , '->' asPParser trimBlanks
	  , self color , '.' asPParser trimBlanks
	  , #newline asPParser trimBlanks optional
	  ==> [ :triple | RMDBackgroundColorRenderer color: triple third ]
]

{ #category : #'parsers-conditions' }
RMDGrammar >> binaryCombinatorFrom: anArray [
	| operator conds |
	anArray size = 1
		ifTrue: [ ^ anArray first ].
	operator := anArray second.
	2 to: anArray size by: 2 do: [ :index | 
		(anArray at: index) = operator
			ifFalse: [ ^ PP2Failure message: 'More than one kinds of logical operators.' ] ].
	conds := (1 to: anArray size by: 2)
		collect: [ :index | anArray at: index ].
	operator = 'and'
		ifTrue: [ ^ self conjunctionNodeClass conditions: conds ].
	operator = 'or'
		ifTrue: [ ^ self disjunctionNodeClass conditions: conds ].
	^ PP2Failure message: 'Unknown operator: ' , operator
]

{ #category : #'parsers-conditions' }
RMDGrammar >> binaryRelation [

	^ expression , self binaryRelationOperator
	  , (expression separatedBy: self binaryRelationOperator)
	  ==> [ :triple | 
		  self binaryRelationFrom:
			  (Array with: triple first with: triple second) , triple third ]
]

{ #category : #'parsers-conditions' }
RMDGrammar >> binaryRelationFrom: anArray [
	| operator expressions |
	anArray size < 3
		ifTrue: [ ^ PP2Failure message: 'No relational operator.' ].
	operator := anArray second.
	4 to: anArray size by: 2 do: [ :index | 
		operator = (anArray at: index)
			ifFalse:
				[ ^ PP2Failure message: 'More than one kinds of relational operators.' ] ].
	expressions := (1 to: anArray size by: 2)
		collect: [ :index | anArray at: index ].
	(operator = '/=' and: [ expressions size > 2 ])
		ifTrue: [ ^ PP2Failure message: '/= can not be cascaded.' ].
	^ (self binaryRelationNodeClassFor: operator)
		expressions: expressions
]

{ #category : #'parsers-conditions' }
RMDGrammar >> binaryRelationNodeClassFor: aString [
	aString = '='
		ifTrue: [ ^ RMDEqualityNode ].
	aString = '<='
		ifTrue: [ ^ RMDLessOrEqualNode ].
	aString = '<'
		ifTrue: [ ^ RMDLessThanNode ].
	aString = '>='
		ifTrue: [ ^ RMDGreaterOrEqualNode ].
	aString = '>'
		ifTrue: [ ^ RMDGreaterThanNode ].
	^ RMDNotEqualNode
]

{ #category : #'parsers-conditions' }
RMDGrammar >> binaryRelationOperator [

	^ ('=' asPParser / '/=' asPParser
	   / ($< asPParser , $= asPParser optional) flatten
	   / ($> asPParser , $= asPParser optional) flatten) trimBlanks
]

{ #category : #'class access' }
RMDGrammar >> bindNodeClass [
	^ RMDTaskDefinitionNode
]

{ #category : #'parsers-visualizations' }
RMDGrammar >> color [

	^ #blank asPParser star , ((PP2ChoiceNode withAll:
		    (Color registeredColorNames collect: [ :n | 
			     n asString asPParser ])) ==> [ :name | Color named: name ]
	   / ($# asPParser , (#hex asPParser times: 6) flatten
		    ==> [ :pair | Color fromHexString: pair second ])) ==> #second
]

{ #category : #'parsers-conditions' }
RMDGrammar >> cond1 [

	^ $( asPParser trimBlanks , condition , $) asPParser trimBlanks
	  ==> #second / self binaryRelation / self placeholder
]

{ #category : #'parsers-conditions' }
RMDGrammar >> cond2 [
	^ ('not' asPParser trimBlanks optional , self cond1)
		==> [ :pair | 
			pair first
				ifNotNil: [ self negationNodeClass condition: pair second ]
				ifNil: [ pair second ] ]
]

{ #category : #'parsers-conditions' }
RMDGrammar >> cond3 [
	^ (self cond2
		separatedBy: ('and' asPParser / 'or' asPParser) trimBlanks)
		==> [ :array | self binaryCombinatorFrom: array ]
]

{ #category : #'parsers-conditions' }
RMDGrammar >> condition [

	^ self cond3
]

{ #category : #'class access' }
RMDGrammar >> conjunctionNodeClass [
	^ RMDConjunctionNode
]

{ #category : #'class access' }
RMDGrammar >> deUnitExpressionNode [

	^ RMDDeUnitExpressionNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> decimalString [

	^ ($- asPParser optional , #digit asPParser plus
	   , ($. asPParser , #digit asPParser plus) optional) flatten
]

{ #category : #'parsers-definitions' }
RMDGrammar >> definition [
	^ self attributeDefinition
]

{ #category : #'parsers-atoms' }
RMDGrammar >> delta [
	^ ('delta ' asPParser / 'Δ' asPParser) trimBlanks
]

{ #category : #'parsers-directives' }
RMDGrammar >> dieDirective [

	^ 'die' asPParser trimBlanks
	  ==> [ :die | self dieDirectiveNodeClass new ]
]

{ #category : #'class access' }
RMDGrammar >> dieDirectiveNodeClass [

	^ RMDDieDirectiveNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential [
	^ 'd/dt ' asPParser trimBlanks
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential2 [
	^ ('d2/dt2 ' asPParser / 'd^2/dt^2 ' asPParser) trimBlanks
]

{ #category : #'parsers-directives' }
RMDGrammar >> directionDirective [
	^ ('direction' asPParser trimBlanks , identifier)
		==>
			[ :pair | self agentDirectiveNodeClass directive: pair first agent: pair second ]
]

{ #category : #'parsers-directives' }
RMDGrammar >> directionOfGradientDirective [
	^ ('direction' asPParser trimLeft , #blank asPParser plus
		, ('neighbor''s' asPParser / 'neighbour''s' asPParser) trim
		, identifier)
		==> [ :pair | 
			self patchDirectiveNodeClass
				directive: 'direction'
				identifier: pair fourth ]
]

{ #category : #'class access' }
RMDGrammar >> disjunctionNodeClass [
	^ RMDDisjunctionNode
]

{ #category : #'parsers-directives' }
RMDGrammar >> distanceDirective [
	^ ('distance' asPParser trimBlanks , identifier)
		==>
			[ :pair | self agentDirectiveNodeClass directive: pair first agent: pair second ]
]

{ #category : #'class access' }
RMDGrammar >> enUnitExpressionNode [

	^ RMDEnUnitExpressionNode
]

{ #category : #units }
RMDGrammar >> energyUnits [
	^ {('J' -> #(1.0 nil 'J')).
	('kJ' -> #(1000.0 nil 'J')).
	('kcal' -> #(4184.0 nil 'J')).
	('cal' -> #(4.184 nil 'J'))} asDictionary
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expr1 [

	^ ($( asPParser trimBlanks , self unit , $) asPParser trimBlanks
	   ==> #second) optional
	  , (literal / ('-' asPParser trimBlanks optional
		    , (self parenExpression / self agentDirective / self apply
			     / self attributeVariable / self placeholder
			     / self utilityVariable) ==> [ :pair | 
		    pair first
			    ifNil: [ pair second ]
			    ifNotNil: [ self unaryMinusNodeClass expression: pair second ] ]))
	  , ($[ asPParser trimBlanks , self unit , $] asPParser trimBlanks
		   ==> #second) optional ==> [ :triple | 
	  | expr |
	  expr := triple second.
	  triple first
		  ifNil: [ 
			  triple third
				  ifNil: [ expr ]
				  ifNotNil: [ :enUnit | 
				  self enUnitExpressionNode expression: expr unit: enUnit ] ]
		  ifNotNil: [ :deUnit | 
			  triple third
				  ifNil: [ 
				  self deUnitExpressionNode expression: expr unit: deUnit ]
				  ifNotNil: [ :enunit | 
				  PP2Failure message: 'ambiguous unit conversion' ] ] ]
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expr2 [
	^ (self expr1
		, (($^ asPParser trimBlanks , self int) ==> #second) optional)
		==> [ :pair | 
			pair second
				ifNil: [ pair first ]
				ifNotNil: [ self powerNodeClass expression: pair first order: pair second ] ]
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expr3 [
	^ (self expr2 separatedBy: $* asPParser trimBlanks)
		==> [ :array | 
			(3 to: array size by: 2)
				inject: array first
				into: [ :product :index | 
					self productNodeClass
						expression: product
						expression: (array at: index) ] ]
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expr4 [
	| expr3 |
	expr3 := self expr3.
	^ (expr3
		,
			((#newline asPParser trimBlanks optional , $/ asPParser trimBlanks
				, expr3) ==> #third) optional)
		==> [ :pair | 
			pair second
				ifNil: [ pair first ]
				ifNotNil: [ self fractionNodeClass
						expression: pair first
						expression: pair second ] ]
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expr5 [
	^ (self expr4 separatedBy: ($+ asPParser / $- asPParser) trimBlanks)
		==> [ :array | 
			(2 to: array size by: 2)
				inject: array first
				into: [ :total :index | 
					| op |
					op := array at: index.
					(op = $+
						ifTrue: [ self additionNodeClass ]
						ifFalse: [ self subtractionNodeClass ])
						expression: total
						expression: (array at: index + 1) ] ]
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expr6 [

	^ self uniformDistribution / self normalDistribution
	  / self gammaDistribution / self logLogisticDistribution
	  / self expr5
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expression [
	^ self expr6
]

{ #category : #'class access' }
RMDGrammar >> externalVariableNodeClass [
	^ RMDUtilityVariableNode
]

{ #category : #'class access' }
RMDGrammar >> fractionNodeClass [
	^ RMDFractionNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> fractionString [

	^ self decimalString / self pi
	  ,
		  ($/ asPParser trimBlanks flatten , (self decimalString / self pi))
			  optional ==> [ :pair | 
	  pair first , (pair second
		   ifNotNil: [ :pair2 | pair2 first , pair2 second ]
		   ifNil: [ '' ]) ]
]

{ #category : #'parsers-expressions' }
RMDGrammar >> gammaDistribution [
	^ ('gamma' asPParser trimBlanks , self expr5
		, 'scale' asPParser trimBlanks , self expr5)
		==>
			[ :quad | self gammaDistributionNodeClass shape: quad second scale: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> gammaDistributionNodeClass [

	^ RMDGammaDistributionNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> guard [
	^ ('if ' asPParser trimBlanks , condition , $, asPParser trimBlanks
		, #newline asPParser trimBlanks optional) ==> #second
]

{ #category : #'parsers-expressions' }
RMDGrammar >> guardedChoice [
	^ (expression separatedBy: self guard)
		==> [ :array | 
			array size = 1
				ifTrue: [ array first ]
				ifFalse: [ self guardedChoiceNodeClass
						from:
							(((1 to: array size - 1 by: 2)
								collect: [ :index | (array at: index + 1) -> (array at: index) ])
								copyWith: true -> array last) ] ]
]

{ #category : #'class access' }
RMDGrammar >> guardedChoiceNodeClass [
	^ RMDGuardedChoiceNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> identifier [
	^ (#letter asPParser
		, (#letter asPParser / #digit asPParser / $_ asPParser) star)
		flatten
		==> [ :name | 
			(self keywords includes: name)
				ifTrue: [ PP2Failure message: name , ' is a reserved word.' ]
				ifFalse: [ name first isLowercase
						ifTrue: [ name ]
						ifFalse: [ PP2Failure
								message: 'An identifier must start with a lowercase letter.' ] ] ]
]

{ #category : #'parsers-atoms' }
RMDGrammar >> int [

	^ $- asPParser optional , self nat
	  ==> [ :pair | 
	  (pair first ifNil: [ 1 ] ifNotNil: [ -1 ]) * pair second ]
]

{ #category : #accessing }
RMDGrammar >> keywords [
	^ Keywords
		ifNil:
			[ Keywords := 'nearest distance direction delta is with if where become otherwise time my the'
				substrings asSet ]
]

{ #category : #'parsers-directives' }
RMDGrammar >> killDirective [

	^ 'kill' asPParser trimBlanks
	  ==> [ :die | self killDirectiveNodeClass new ]
]

{ #category : #'class access' }
RMDGrammar >> killDirectiveNodeClass [

	^ RMDKillDirectiveNode
]

{ #category : #units }
RMDGrammar >> lengthUnits [
	^ {('km' -> #(1000.0 nil 'm')).
	('m' -> #(1.0 nil 'm')).
	('cm' -> #(0.01 nil 'm')).
	('mm' -> #(0.001 nil 'm'))} asDictionary
]

{ #category : #'parsers-directives' }
RMDGrammar >> lifeDirective [

	^ self dieDirective / self killDirective / self newDirective / self stageDirective
]

{ #category : #'parsers-atoms' }
RMDGrammar >> literal [

	^ self fractionString , self type optional ==> [ :pair | 
	  self literalNodeClass
		  literal: pair first
		  unit: (pair second ifNil: [ RMDUnit noDimension ]) ]
]

{ #category : #'class access' }
RMDGrammar >> literalNodeClass [
	^ RMDLiteralNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> logLogisticDistribution [

	^ ('loglogistic' asPParser / 'fisk' asPParser) trimBlanks
	  , self expr5 , 'shape' asPParser trimBlanks , self expr5
	  ==> [ :quad | 
		  self logLogisticDistributionNodeClass
			  scale: quad second
			  shape: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> logLogisticDistributionNodeClass [

	^ RMDLogLogisticDistributionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> namely [

	^ 'namely' asPParser trimBlanks
]

{ #category : #'parsers-atoms' }
RMDGrammar >> nat [

	^ #digit asPParser plus
	  ==> [ :digits | 
	  digits inject: 0 into: [ :i :c | i * 10 + c digitValue ] ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> nearest [

	^ #blank asPParser , 'nearest' asPParser , #blank asPParser
]

{ #category : #'class access' }
RMDGrammar >> negationNodeClass [
	^ RMDNegationNode
]

{ #category : #'class access' }
RMDGrammar >> newAttributeVariableNodeClass [

	^ RMDNewAttributeVariableNode
]

{ #category : #'parsers-directives' }
RMDGrammar >> newDirective [

	^ 'new' asPParser , #blank asPParser plus
	  , (expression , agentIdentifier
		   / ('-' asPParser trimBlanks ==> [ :minus | nil ]))
	  ==> [ :triple | 
		  triple third
			  ifNil: [ self newDirectiveNodeClass new ]
			  ifNotNil: [ :pair | 
				  self newDirectiveNodeClass
					  animatIdentifier: pair second
					  quantity: pair first ] ]
]

{ #category : #'class access' }
RMDGrammar >> newDirectiveNodeClass [

	^ RMDNewDirectiveNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> normalDistribution [
	^ ('normal' asPParser trimBlanks , self expr5
		, 'sigma' asPParser trimBlanks , self expr5)
		==>
			[ :quad | self normalDistributionNodeClass mean: quad second sigma: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> normalDistributionNodeClass [

	^ RMDNormalDistributionNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> parenExpression [
	^ ($( asPParser , guardedChoice , $) asPParser) ==> #second
]

{ #category : #'parsers-visualizations' }
RMDGrammar >> patchColorAlphaRenderer [

	^ 'Patch' asPParser trimBlanks , '->' asPParser trimBlanks
	  , self color , 'with' asPParser trimBlanks
	  , 'alpha' asPParser trimBlanks
	  , 'proportional' asPParser trimBlanks , 'to' asPParser trimBlanks
	  , expression , 'between' asPParser trimBlanks , literal
	  , 'and' asPParser trimBlanks , literal
	  , 'with' asPParser trimBlanks , self nat
	  , 'pixels' asPParser trimBlanks , self color
	  , 'grids' asPParser trimBlanks , '.' asPParser
	  , #newline asPParser trimBlanks optional ==> [ :array | 
	  (RMDPatchColorAlphaRenderer
		   color: (array at: 3)
		   alpha: (array at: 8)
		   between: (array at: 10)
		   and: (array at: 12))
		  borderWidth: (array at: 14);
		  borderColor: (array at: 16);
		  yourself ]
]

{ #category : #'parsers-visualizations' }
RMDGrammar >> patchColorBrightnessRenderer [

	^ 'Patch' asPParser trimBlanks , '->' asPParser trimBlanks
	  , self color , 'with' asPParser trimBlanks
	  , 'brightness' asPParser trimBlanks
	  , 'proportional' asPParser trimBlanks , 'to' asPParser trimBlanks
	  , expression , 'between' asPParser trimBlanks , literal
	  , 'and' asPParser trimBlanks , literal
	  , 'with' asPParser trimBlanks , self nat
	  , 'pixels' asPParser trimBlanks , self color
	  , 'grids' asPParser trimBlanks , '.' asPParser
	  , #newline asPParser trimBlanks optional ==> [ :array | 
	  (RMDPatchColorBrightnessRenderer
		   color: (array at: 3)
		   brightness: (array at: 8)
		   between: (array at: 10)
		   and: (array at: 12))
		  borderWidth: (array at: 14);
		  borderColor: (array at: 16);
		  yourself ]
]

{ #category : #'parsers-visualizations' }
RMDGrammar >> patchColorMapRenderer [

	^ 'Patch' asPParser trimBlanks , '->' asPParser trimBlanks
	  , 'map' asPParser trimBlanks , expression
	  , 'with' asPParser trimBlanks , #newline asPParser trimBlanks
	  ==> #fourth
	  ,
		  (self color , 'if' asPParser trimBlanks
		   , '>=' asPParser trimBlanks , self literal
		   , ',' asPParser trimBlanks , #newline asPParser
		   ==> [ :array | (array at: 4) -> (array at: 1) ]) star
	  , self color
	  , (#newline asPParser , 'with' asPParser trimBlanks , self nat
		   , 'pixels' asPParser trimBlanks ==> #third)
	  ,
	  (self color , 'grids' asPParser trimBlanks , '.' asPParser
	   ==> #first) , #newline asPParser optional ==> [ :array | 
	  | renderer |
	  renderer := RMDPatchColorMapRenderer
		              expression: (array at: 1)
		              color: (array at: 3).
	  (array at: 2) do: [ :assoc | 
		  renderer add: assoc value at: assoc key ].
	  renderer
		  borderWidth: (array at: 4);
		  borderColor: (array at: 5).
	  renderer ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> patchDefinition [
	^ ('Patch' asPParser
		,
			((#blank asPParser , 'with' asPParser trimBlanks
				, #newline asPParser trimBlanks
				,
					(self attributeDeclaration
						onlySeparatedBy: #newline asPParser trimBlanks)
				, #newline asPParser trimBlanks optional) ==> #fourth) optional
		, '.' asPParser trimBlanks , #newline asPParser trimBlanks optional)
		==> [ :pair | 
			self patchDefinitionNodeClass
				attributeDeclarations: (pair second ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> patchDefinitionNodeClass [
	^ RMDPatchDefinitionNode
]

{ #category : #'class access' }
RMDGrammar >> patchDirectiveNodeClass [
	^ RMDPatchDirectiveNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> patchInitializer [
	^ (#digit asPParser plus flatten trimBlanks , 'x' asPParser
		, #digit asPParser plus flatten trimBlanks
		, 'of' asPParser trimBlanks , literal , 'Patch' asPParser trimBlanks
		,
			(('with' asPParser , #newline asPParser trimBlanks
				,
					(self attributeInitializer
						onlySeparatedBy: #newline asPParser trimBlanks)) ==> #last)
				optional)
		==> [ :array | 
			self patchInitializerNodeClass
				xDivisions: array first asInteger
				yDivisions: array third asInteger
				length: array fifth
				patchAttributeInitializers: (array seventh ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> patchInitializerNodeClass [
	^ RMDPatchInitializerNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> pi [

	^ $- asPParser trimBlanks optional
	  , ('π' asPParser / 'pi' asPParser) trimBlanks
	  ==> [ :pair | (pair first ifNil: [ '' ] ifNotNil: [ '-' ]) , 'π' ]
]

{ #category : #'parsers-atoms' }
RMDGrammar >> placeholder [

	^ 'the' asPParser , #blank asPParser plus , identifier
	  ==> [ :triple | 
	  self placeholderNodeClass identifier: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> placeholderNodeClass [
	^ RMDPlaceholderNode
]

{ #category : #'class access' }
RMDGrammar >> powerNodeClass [
	^ RMDPowerNode
]

{ #category : #'class access' }
RMDGrammar >> productNodeClass [
	^ RMDProductNode
]

{ #category : #'parsers-visualizations' }
RMDGrammar >> renderer [

	^ self animatDotRenderer / self backgroundColorRenderer
	  / self patchColorAlphaRenderer / self patchColorBrightnessRenderer
	  / self patchColorMapRenderer
]

{ #category : #'parsers-definitions' }
RMDGrammar >> simulationDefinition [
	^ (('Simulation' asPParser trimBlanks , 'with' asPParser
		, #newline asPParser trimBlanks) ==> [ :triple | nil ]
		,
			((self simulationTimeDefinition , #newline asPParser trimBlanks optional)
				==> #first) , self worldInitializer optional
		, ((self patchInitializer , #newline asPParser trimBlanks optional) ==> #first)
		,
			(self animatInitializer onlySeparatedBy: #newline asPParser trimBlanks) optional
		, '.' asPParser trimBlanks , #newline asPParser trimBlanks optional)
		==> [ :array | 
			self simulationDefinitionNodeClass
				timeDefinition: array second
				worldInitializer: array third
				patchInitializer: array fourth
				animatInitializers: (array fifth ifNil: [ { } ]) ]
]

{ #category : #'class access' }
RMDGrammar >> simulationDefinitionNodeClass [
	^ RMDSimulationDefinitionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> simulationTimeDefinition [
	^ (('during' asPParser trimBlanks , literal) ==> #last
		,
			(('step' asPParser trimBlanks optional , 'by' asPParser trimBlanks
				, literal) ==> #last))
		==> [ :pair | 
			self simulationTimeDefinitionNodeClass
				duration: pair first
				step: pair second ]
]

{ #category : #'class access' }
RMDGrammar >> simulationTimeDefinitionNodeClass [
	^ RMDSimulationTimeDefinitionNode
]

{ #category : #'parsers-directives' }
RMDGrammar >> stageDirective [

	^ 'stage' asPParser , #blank asPParser plus , agentIdentifier
	  ==> [ :triple | 
		  self stageDirectiveNodeClass animatIdentifier: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> stageDirectiveNodeClass [

	^ RMDStageDirectiveNode
]

{ #category : #accessing }
RMDGrammar >> start [
	"Answer the production to start this parser with."
	
	self definition
]

{ #category : #'class access' }
RMDGrammar >> subtractionNodeClass [
	^ RMDSubtractionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> taskDefinition [

	^ self taskDefinitionHeader , self whenClause optional
	  , (#newline asPParser trimBlanks , 'where' asPParser trimBlanks
		   , #newline asPParser trimBlanks
		   ,
		   (self attributeBind onlySeparatedBy: #newline asPParser trimBlanks)
		   ==> #fourth) optional , $. asPParser trimBlanks ==> [ :quad | 
	  self bindNodeClass
		  subjectIdentifier: quad first first
		  verbIdentifier: quad first second
		  objectIdentifier: quad first fourth
		  actionIdentifier: quad first sixth
		  nearest: quad first third
		  within: quad first fifth
		  guard: quad second
		  attributeBinds: (quad third ifNil: [ Array new ]) ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> taskDefinitionHeader [

	^ self taskDefinitionHeaderWithNamely
	  / self taskDefinitionHeaderWithoutNamely
]

{ #category : #'parsers-definitions' }
RMDGrammar >> taskDefinitionHeaderWithNamely [

	^ agentIdentifier , identifier
	  ,
	  (self nearest optional , agentIdentifier , self withinClause)
		  optional , self namely , self actionIdentifier ==> [ :array | 
	  | subject verb nearest object range action |
	  subject := array first.
	  verb := array second.
	  nearest := (array third ifNotNil: #first) notNil.
	  object := array third ifNotNil: #second.
	  range := array third ifNotNil: #third.
	  action := array fifth.
	  { 
		  subject.
		  verb.
		  nearest.
		  object.
		  range.
		  action } ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> taskDefinitionHeaderWithoutNamely [

	^ agentIdentifier , self actionIdentifier
	  ,
	  (self nearest optional , agentIdentifier , self withinClause)
		  optional ==> [ :triple | 
	  | subject verb nearest object range action |
	  subject := triple first.
	  verb := triple second.
	  nearest := (triple third ifNotNil: #first) notNil.
	  object := triple third ifNotNil: #second.
	  range := triple third ifNotNil: #third.
	  action := triple second.
	  { 
		  subject.
		  verb.
		  nearest.
		  object.
		  range.
		  action } ]
]

{ #category : #units }
RMDGrammar >> temperatureUnits [
	^ {('K' -> #(1.0 nil 'K')).
	('C' -> #(1.0 273.15 'K')).
	('F' -> #(0.5555555555555556 255.3722222222222 'J'))} asDictionary
]

{ #category : #'parsers-atoms' }
RMDGrammar >> the [

	^ 'the' asPParser ==> [ :the | #the ] , #blank asPParser plus
	  ==> #first
]

{ #category : #'parsers-directives' }
RMDGrammar >> timeDirective [
	^ (self delta optional , 'time' asPParser trimBlanks)
		==> [ :pair | 
			self agentDirectiveNodeClass
				directive: (pair first ifNil: [ 'time' ] ifNotNil: [ 'delta time' ])
				agent: nil ]
]

{ #category : #units }
RMDGrammar >> timeUnits [
	^ {('ms' -> #(0.001 nil 's')).
	('s' -> #(1.0 nil 's')).
	('min' -> #(60.0 nil 's')).
	('h' -> #(3600.0 nil 's')).
	('day' -> #(86400.0 nil 's'))} asDictionary
]

{ #category : #'parsers-units' }
RMDGrammar >> type [
	^ ($[ asPParser trimBlanks , self unit optional
		, $] asPParser trimBlanks)
		==> [ :triple | triple second ifNil: [ RMDUnit noDimension ] ]
]

{ #category : #'class access' }
RMDGrammar >> unaryMinusNodeClass [
	^ RMDUnaryMinusNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> uniformDistribution [

	^ 'uniform' asPParser trimBlanks , self expr5
	  , 'to' asPParser trimBlanks , self expr5 ==> [ :quad | 
	  self uniformDistributionNodeClass from: quad second to: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> uniformDistributionNodeClass [
	^ RMDUniformDistributionNode
]

{ #category : #'parsers-units' }
RMDGrammar >> unit [
	^ (self unitTerm
		, (('/' asPParser trimBlanks , self unitTerm) ==> #second) optional)
		==> [ :pair | 
			pair second
				ifNotNil: [ pair first / pair second ]
				ifNil: [ pair first ] ]
]

{ #category : #'parsers-units' }
RMDGrammar >> unitFactor [
	^ (self unitSymbol
		,
			(($^ asPParser
				,
					(($- asPParser optional , #digit asPParser)
						==> [ :pair | 
							pair second asString asInteger
								* (pair first ifNil: [ 1 ] ifNotNil: [ -1 ]) ])) ==> #second)
				optional)
		==> [ :pair | 
			pair second
				ifNotNil: [ pair first ** pair second ]
				ifNil: [ pair first ] ]
]

{ #category : #'parsers-units' }
RMDGrammar >> unitSymbol [

	^ (#letter asPParser plus , #digit asPParser optional) flatten
	  ==> [ :symbol | 
		  RMDUnitSymbol
			  at: symbol
			  ifAbsent: [ PP2Failure message: 'Unknown unit symbol: ' , symbol ] ]
]

{ #category : #'parsers-units' }
RMDGrammar >> unitTerm [

	^ (self unitFactor onlySeparatedBy:
		   #blank asPParser plus / $• asPParser / $* asPParser)
	  ==> [ :array | 
		  array inject: RMDUnit noDimension into: [ :unit :f | unit * f ] ]
	  / ('1' asPParser trimBlanks ==> [ :one | RMDUnit noDimension ])
]

{ #category : #'parsers-definitions' }
RMDGrammar >> utilityDefinition [
	^ (self utilityVariable , '=' asPParser trimBlanks , guardedChoice)
		==> [ :triple | 
			self utilityDefinitionNode
				variable: triple first
				expression: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> utilityDefinitionNode [
	^ RMDUtilityDefinitionNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> utilityVariable [
	^ identifier
		==> [ :str | self utilityVariableNodeClass identifier: str ]
]

{ #category : #'class access' }
RMDGrammar >> utilityVariableNodeClass [
	^ RMDUtilityVariableNode
]

{ #category : #units }
RMDGrammar >> weightUnits [
	^ {('t' -> #(1000 nil 'kg')).
	('kg' -> #(1 nil 'kg')).
	('g' -> #(0.001 nil 'kg')).
	('mg' -> #(0.000001 nil 'kg'))} asDictionary
]

{ #category : #'parsers-definitions' }
RMDGrammar >> whenClause [

	^ #newline asPParser trimBlanks , 'when' asPParser trimBlanks
	  , condition ==> #third
]

{ #category : #'parsers-definitions' }
RMDGrammar >> withClause [

	^ #newline asPParser trimBlanks , 'with' asPParser trimBlanks
	  , (self lifeDirective separatedBy: ',' asPParser trimBlanks)
	  ==> [ :triple | 
		  | array |
		  array := triple third.
		  (1 to: array size by: 2) collect: [ :index | array at: index ] ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> withinClause [

	^ 'within' asPParser trimBlanks , literal ==> #second
]

{ #category : #'parsers-definitions' }
RMDGrammar >> worldDefinition [
	^ ('World' asPParser
		,
			((#blank asPParser plus , 'with' asPParser trimBlanks
				, #newline asPParser trimBlanks
				,
					(self attributeDeclaration
						onlySeparatedBy: #newline asPParser trimBlanks)) ==> #fourth)
				optional , '.' asPParser trimBlanks
		, #newline asPParser trimBlanks optional)
		==> [ :pair | 
			self worldDefinitionNodeClass
				attributeDeclarations: (pair second ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> worldDefinitionNodeClass [
	^ RMDWorldDefinitionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> worldInitializer [

	^ ('World' asPParser trimBlanks
	   , ('with' asPParser trimBlanks , #newline asPParser trimBlanks
		    , (self attributeInitializer onlySeparatedBy:
				     #newline asPParser trimBlanks) ==> #third) optional
	   ==> #second , #newline asPParser trimBlanks optional ==> #first)
		  optional ==> [ :initializers | 
	  self worldInitializerNodeClass attributeInitializers:
		  (initializers ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> worldInitializerNodeClass [
	^ RMDWorldInitializerNode
]
