Class {
	#name : #RMDGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'definition',
		'expression',
		'identifier',
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
	^ (self actionDefinitionHeaderLine , self actionDefinitionPresumeLine optional
		, self actionDefinitionPropertyPart , self actionDefinitionUtilityPart optional
		, '.' asPParser trimBlanks , #newline asPParser trimBlanks optional)
		==> [ :quad | 
			self actionDefinitionNodeClass
				name: quad first first
				object: quad first second
				guard: (quad second ifNil: [ true ])
				propertyDefinitions: quad third
				utilityDefinitions: (quad fourth ifNil: [ Array new ]) ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinitionHeaderLine [
	^ ('to' asPParser trimBlanks , identifier trimBlanks
		, identifier optional , 'is' asPParser trimBlanks
		, #newline asPParser trimBlanks)
		==> [ :array | 
			{array second.
			array third} ]
]

{ #category : #'class access' }
RMDGrammar >> actionDefinitionNodeClass [
	^ RMDActionDefinitionNode 
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinitionPresumeLine [
	^ ('presume' asPParser trimBlanks , condition
		, #newline asPParser trimBlanks) ==> #second
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinitionPropertyPart [
	^ ((self propertyDefinition
		onlySeparatedBy: #newline asPParser trimBlanks)
		, #newline asPParser trimBlanks optional) ==> #first
]

{ #category : #'parsers-definitions' }
RMDGrammar >> actionDefinitionUtilityPart [
	^ ('where' asPParser trimBlanks , #newline asPParser trimBlanks
		,
			(self utilityDefinition onlySeparatedBy: #newline asPParser trimBlanks)
		, #newline asPParser trimBlanks optional) ==> #third
]

{ #category : #'class access' }
RMDGrammar >> additionNodeClass [
	^ RMDAdditionNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> agentDirective [
	^ ((('distance' asPParser / 'direction' asPParser) trimBlanks
		, identifier)
		==>
			[ :pair | self agentDirectiveNodeClass directive: pair first agent: pair second ])
		/
			(('terminate' asPParser trimBlanks , identifier optional)
				==>
					[ :pair | self agentDirectiveNodeClass directive: pair first agent: pair second ])
		/
			((self delta optional , 'time' asPParser trimBlanks)
				==> [ :pair | 
					self agentDirectiveNodeClass
						directive: (pair first ifNil: [ 'time' ] ifNotNil: [ 'dtime' ])
						agent: nil ])
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
	^ (('my' asPParser, #space asPParser) trimBlanks ==> [ :str | nil ])
		/ 'the' asPParser trimBlanks
		/ ((identifier , '''s ' asPParser trimBlanks) ==> #first)
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
RMDGrammar >> animatDefinition [
	^ (self animatHeader , self animatPropertyPart optional
		, '.' asPParser trimBlanks , #newline asPParser trimBlanks optional)
		==> [ :quad | 
			self animatDefinitionNodeClass
				identifier: quad first
				propertyDeclarations: (quad second ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> animatDefinitionNodeClass [
	^ RMDAnimatDefinitionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> animatHeader [
	^ (self agentIdentifier , 'is' asPParser trimBlanks
		, 'Animat' asPParser trimBlanks) ==> #first
]

{ #category : #'parsers-definitions' }
RMDGrammar >> animatInitializer [
	^ (#digit asPParser plus flatten trimBlanks , self agentIdentifier
		,
			(('with' asPParser trimBlanks , #newline asPParser trimBlanks
				,
					(self propertyInitializer
						onlySeparatedBy: #newline asPParser trimBlanks)) ==> #third)
				optional)
		==> [ :triple | 
			self animatInitializerNodeClass
				population: triple first asInteger
				animat: triple second
				propertyInitializers: (triple third ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> animatInitializerNodeClass [
	^ RMDAnimatInitializerNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> animatPropertyPart [
	^ ('with' asPParser trimBlanks , #newline asPParser trimBlanks
		,
			(self propertyDeclaration
				onlySeparatedBy: #newline asPParser trimBlanks)
		, #newline asPParser trimBlanks optional) ==> #third
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

{ #category : #'parsers-definitions' }
RMDGrammar >> behaviorDefinition [
	^ (self behaviorDefinitionHeader
		,
			(('where' asPParser trimBlanks , #newline asPParser trimBlanks
				, (self propertyBind onlySeparatedBy: #newline asPParser trimBlanks))
				==> #third) optional , $. asPParser trimBlanks)
		==> [ :triple | 
			self bindNodeClass
				subjectIdentifier: triple first first
				scriptIdentifier: triple first second
				objectIdentifier: triple first third
				within: triple first fourth
				propertyBinds: (triple second ifNil: [ Array new ]) ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> behaviorDefinitionHeader [
	^ (self agentIdentifier , identifier , self agentIdentifier optional
		, (('within' asPParser trimBlanks , literal) ==> #second) optional)
		==> [ :array | 
			{array first.
			array second.
			array third.
			array fourth} ]
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
	^ (expression
		separatedBy:
			('=' asPParser / '/=' asPParser
				/ ($< asPParser , $= asPParser optional) flatten
				/ ($> asPParser , $= asPParser optional) flatten) trimBlanks)
		==> [ :array | self binaryRelationFrom: array ]
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

{ #category : #'class access' }
RMDGrammar >> bindNodeClass [
	^ RMDBehaviorDefinitionNode
]

{ #category : #accessing }
RMDGrammar >> builtins [
	^ Builtins
		ifNil:
			[ Builtins := 'World Cell Animat x y heading North South West East world cell north south east west'
				substrings asSet ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> cellDefinition [
	^ ('Cell' asPParser
		,
			((#blank asPParser , 'with' asPParser trimBlanks
				, #newline asPParser trimBlanks
				,
					(self propertyDeclaration
						onlySeparatedBy: #newline asPParser trimBlanks)
				, #newline asPParser trimBlanks optional) ==> #fourth) optional
		, '.' asPParser trimBlanks , #newline asPParser trimBlanks optional)
		==> [ :pair | 
			self cellDefinitionNodeClass
				propertyDeclarations: (pair second ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> cellDefinitionNodeClass [
	^ RMDCellDefinitionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> cellInitializer [
	^ (#digit asPParser plus flatten trimBlanks , 'x' asPParser
		, #digit asPParser plus flatten trimBlanks
		, 'of' asPParser trimBlanks , literal , 'Cell' asPParser trimBlanks
		,
			(('with' asPParser , #newline asPParser trimBlanks
				,
					(self propertyInitializer
						onlySeparatedBy: #newline asPParser trimBlanks)) ==> #last)
				optional)
		==> [ :array | 
			self cellInitializerNodeClass
				xDivisions: array first asInteger
				yDivisions: array third asInteger
				length: array fifth
				cellPropertyInitializers: (array seventh ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> cellInitializerNodeClass [
	^ RMDCellInitializerNode
]

{ #category : #'parsers-conditions' }
RMDGrammar >> cond1 [
	^ ($( asPParser trimBlanks, condition, $) asPParser trimBlanks ==> #second) / self binaryRelation
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

{ #category : #'parsers-definitions' }
RMDGrammar >> definition [
	^ self propertyDefinition
]

{ #category : #'parsers-atoms' }
RMDGrammar >> delta [
	^ ('delta ' asPParser / 'Δ' asPParser) trimBlanks
]

{ #category : #'parsers-atoms' }
RMDGrammar >> deltaVariable [
	^ (agentReference , self delta , identifier)
		==> [ :triple | 
			self deltaVariableNodeClass
				identifier: triple third
				agent: triple first ]
]

{ #category : #'class access' }
RMDGrammar >> deltaVariableNodeClass [
	^ RMDDeltaVariableNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential [
	^ 'd/dt ' asPParser trimBlanks
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential2 [
	^ ('d2/dt2 ' asPParser / 'd^2/dt^2 ' asPParser) trimBlanks
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differentialVariable [
	^ (agentReference , self differential , identifier)
		==> [ :triple | 
			self differentialVariableNodeClass
				identifier: triple third
				agent: triple first ]
]

{ #category : #'class access' }
RMDGrammar >> differentialVariableNodeClass [
	^ RMDDifferentialVariableNode
]

{ #category : #'class access' }
RMDGrammar >> disjunctionNodeClass [
	^ RMDDisjunctionNode
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
	^ literal
		/
			(('-' asPParser trimBlanks optional
				,
					(self parenExpression / self agentDirective / self uniformDistribution
						/ self apply / self propertyVariable / self utilityVariable))
				==> [ :pair | 
					pair first
						ifNil: [ pair second ]
						ifNotNil: [ self unaryMinusNodeClass expression: pair second ] ])
]

{ #category : #'parsers-expressions' }
RMDGrammar >> expr2 [
	| expr1 |
	expr1 := self expr1.
	^ (expr1 , (($^ asPParser trimBlanks , expr1) ==> #second) optional)
		==> [ :pair | 
			pair second
				ifNil: [ pair first ]
				ifNotNil:
					[ self powerNodeClass expression: pair first expression: pair second ] ]
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
RMDGrammar >> expression [
	^ self expr5
]

{ #category : #'class access' }
RMDGrammar >> externalVariableNodeClass [
	^ RMDUtilityVariableNode
]

{ #category : #'class access' }
RMDGrammar >> fractionNodeClass [
	^ RMDFractionNode
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

{ #category : #accessing }
RMDGrammar >> keywords [
	^ Keywords
		ifNil:
			[ Keywords := 'nearest distance direction delta is with if where die kill forward move go become otherwise time'
				substrings asSet ]
]

{ #category : #units }
RMDGrammar >> lengthUnits [
	^ {('km' -> #(1000.0 nil 'm')).
	('m' -> #(1.0 nil 'm')).
	('cm' -> #(0.01 nil 'm')).
	('mm' -> #(0.001 nil 'm'))} asDictionary
]

{ #category : #'parsers-atoms' }
RMDGrammar >> literal [
	^ (($- asPParser optional , #digit asPParser plus
		, ($. asPParser , #digit asPParser plus) optional) flatten
		, self type optional)
		==> [ :pair | 
			self literalNodeClass
				literal: pair first
				type: (pair second ifNil: [ RMDUnit noDimension ]) ]
]

{ #category : #'class access' }
RMDGrammar >> literalNodeClass [
	^ RMDLiteralNode
]

{ #category : #'class access' }
RMDGrammar >> negationNodeClass [
	^ RMDNegationNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> parenExpression [
	^ ($( asPParser , guardedChoice , $) asPParser) ==> #second
]

{ #category : #'class access' }
RMDGrammar >> powerNodeClass [
	^ RMDPowerNode
]

{ #category : #'class access' }
RMDGrammar >> productNodeClass [
	^ RMDProductNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> propertyBind [
	^ (self agentReference , identifier , '->' asPParser trimBlanks
		, expression)
		==> [ :quad | 
			self propertyBindNodeClass
				actionAgent: quad first
				property: quad second
				expression: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> propertyBindNodeClass [
	^ RMDPropertyBindNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> propertyDeclaration [
	^ (identifier , self type)
		==> [ :pair | 
			self propertyDeclarationNodeClass
				identifier: pair first
				unit: pair second ]
]

{ #category : #'class access' }
RMDGrammar >> propertyDeclarationNodeClass [
	^ RMDPropertyDeclarationNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> propertyDefinition [
	^ (self differentialVariable / self deltaVariable / self variable , $' asPParser trimBlanks
		, '=' asPParser trimBlanks , guardedChoice)
		==> [ :quad | 
			self propertyDefinitionNodeClass
				variable: quad first
				expression: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> propertyDefinitionNodeClass [
	^ RMDPropertyDefinitionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> propertyInitializer [
	^ (identifier , '=' asPParser trimBlanks , expression)
		==> [ :triple | 
			self propertyInitializerNodeClass
				identifier: triple first
				expression: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> propertyInitializerNodeClass [
	^ RMDPropertyInitializerNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> propertyVariable [
	^ (agentReference , identifier)
		==> [ :pair | 
			self propertyVariableNodeClass
				identifier: pair second
				agent: pair first ]
]

{ #category : #'class access' }
RMDGrammar >> propertyVariableNodeClass [
	^ RMDPropertyVariableNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> simulationDefinition [
	^ (('Simulation' asPParser trimBlanks , 'with' asPParser
		, #newline asPParser trimBlanks) ==> [ :triple | nil ]
		,
			((self simulationTimeDefinition , #newline asPParser trimBlanks)
				==> #first) , self worldInitializer optional
		, ((self cellInitializer , #newline asPParser trimBlanks) ==> #first)
		,
			(self animatInitializer onlySeparatedBy: #newline asPParser trimBlanks))
		==> [ :array | 
			self simulationDefinitionNodeClass
				timeDefinition: array second
				worldInitializer: array third
				cellInitializer: array fourth
				animatInitializers: array fifth ]
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

{ #category : #accessing }
RMDGrammar >> start [
	"Answer the production to start this parser with."
	
	self definition
]

{ #category : #'class access' }
RMDGrammar >> subtractionNodeClass [
	^ RMDSubtractionNode
]

{ #category : #units }
RMDGrammar >> temperatureUnits [
	^ {('K' -> #(1.0 nil 'K')).
	('C' -> #(1.0 273.15 'K')).
	('F' -> #(0.5555555555555556 255.3722222222222 'J'))} asDictionary
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

{ #category : #'parsers-atoms' }
RMDGrammar >> uniformDistribution [
	^ ('uniform' asPParser trimBlanks , literal
		, 'to' asPParser trimBlanks , literal)
		==>
			[ :quad | self uniformDistributionNodeClass from: quad second to: quad fourth ]
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
	^ #letter asPParser plus flatten
		==> [ :symbol | 
			RMDUnitSymbol
				at: symbol
				ifAbsent: [ PP2Failure message: 'Unknown unit symbol: ' , symbol ] ]
]

{ #category : #'parsers-units' }
RMDGrammar >> unitTerm [
	^ (self unitFactor onlySeparatedBy: #blank asPParser plus)
		==>
			[ :array | array inject: RMDUnit noDimension into: [ :unit :f | unit * f ] ]
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

{ #category : #'parsers-atoms' }
RMDGrammar >> variable [
	^ (agentReference , identifier)
		==>
			[ :pair | self variableNodeClass identifier: pair second agent: pair first ]
]

{ #category : #'class access' }
RMDGrammar >> variableNodeClass [
	^ RMDVariableNode
]

{ #category : #units }
RMDGrammar >> weightUnits [
	^ {('t' -> #(1000 nil 'kg')).
	('kg' -> #(1 nil 'kg')).
	('g' -> #(0.001 nil 'kg')).
	('mg' -> #(0.000001 nil 'kg'))} asDictionary
]

{ #category : #'parsers-definitions' }
RMDGrammar >> worldDefinition [
	^ ('World' asPParser
		,
			((#blank asPParser plus , 'with' asPParser trimBlanks
				, #newline asPParser trimBlanks
				,
					(self propertyDeclaration
						onlySeparatedBy: #newline asPParser trimBlanks)) ==> #fourth)
				optional , '.' asPParser trimBlanks
		, #newline asPParser trimBlanks optional)
		==> [ :pair | 
			self worldDefinitionNodeClass
				propertyDeclarations: (pair second ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> worldDefinitionNodeClass [
	^ RMDWorldDefinitionNode
]

{ #category : #'parsers-definitions' }
RMDGrammar >> worldInitializer [
	^ (('World' asPParser trimBlanks , 'with' asPParser trimBlanks
		, #newline asPParser trimBlanks
		,
			(self propertyInitializer
				onlySeparatedBy: #newline asPParser trimBlanks)
		, #newline asPParser trimBlanks optional) ==> #fourth) optional
		==> [ :initializers | 
			self worldInitializerNodeClass
				propertyInitializers: (initializers ifNil: [ Array new ]) ]
]

{ #category : #'class access' }
RMDGrammar >> worldInitializerNodeClass [
	^ RMDWorldInitializerNode
]
