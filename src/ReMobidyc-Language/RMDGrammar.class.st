Class {
	#name : #RMDGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'definition',
		'expression',
		'identifier'
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

{ #category : #'class access' }
RMDGrammar >> additionNodeClass [
	^ RMDAdditionNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> agentReference [
	^ (#letter asPParser
		, (#letter asPParser / #digit asPParser / $_ asPParser) star)
		flatten
		==> [ :name | 
			(self keywords includes: name)
				ifTrue: [ PP2Failure message: name , ' is a reserved word.' ]
				ifFalse: [ name first isUppercase
						ifTrue: [ self agentReferenceNodeClass identifier: name ]
						ifFalse: [ PP2Failure
								message: 'An agent name must start with a uppercase letter.' ] ] ]
]

{ #category : #'class access' }
RMDGrammar >> agentReferenceNodeClass [
	^ RMDAgentReferenceNode
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

{ #category : #'parsers-expressions' }
RMDGrammar >> apply [
	^ (identifier , $( asPParser trimBlanks
		,
			((expression separatedBy: $, asPParser trimBlanks)
				==>
					[ :array | (1 to: array size by: 2) collect: [ :index | array at: index ] ])
		, $) asPParser trimBlanks)
		==>
			[ :quad | self applyNodeClass function: quad first expressions: quad third ]
]

{ #category : #'class access' }
RMDGrammar >> applyNodeClass [
	^ RMDApplyNode
]

{ #category : #accessing }
RMDGrammar >> builtins [
	^ Builtins
		ifNil:
			[ Builtins := 'World Cell Animat x y heading North South West East north south east west'
				substrings asSet ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> definition [
	^ self propertyDefinition
]

{ #category : #'parsers-atoms' }
RMDGrammar >> delta [
	^ (('delta' asPParser , #blank asPParser plus)
		/ 'Δ' asPParser trimBlanks , identifier)
		==> [ :pair | self deltaNodeClass identifier: pair second ]
]

{ #category : #'class access' }
RMDGrammar >> deltaNodeClass [
	^ RMDDeltaVariableNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential [
	^ ('d/dt' asPParser , #blank asPParser plus , identifier)
		==> [ :triple | self differentialNodeClass identifier: triple third ]
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential2 [
	^ ('d2/dt2' asPParser / 'd^2/dt^2' asPParser , #blank asPParser plus
		, identifier)
		==> [ :triple | self differential2NodeClass identifier: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> differential2NodeClass [
	^ RMDDifferential2VariableNode
]

{ #category : #'class access' }
RMDGrammar >> differentialNodeClass [
	^ RMDDifferentialVariableNode
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
	^ self parenExpression / self apply / self differential
		/ self differential2 / self delta / self variable / self literal
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
	^ (expr3 , (($/ asPParser trimBlanks , expr3) ==> #second) optional)
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

{ #category : #'parsers-atoms' }
RMDGrammar >> externalVariable [
	^ (self agentReference
		, ('''s' asPParser , #blank asPParser) trimBlanks , identifier)
		==> [ :triple | 
			self externalVariableNodeClass
				agent: triple first
				identifier: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> externalVariableNodeClass [
	^ RMDExternalVariableNode
]

{ #category : #'class access' }
RMDGrammar >> fractionNodeClass [
	^ RMDFractionNode
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
			[ Keywords := 'nearest distance direction delta d d2 dt dt2 is with if where die kill forward move go become'
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
		, self type)
		==>
			[ :pair | self literalNodeClass literal: pair first type: pair second ]
]

{ #category : #'class access' }
RMDGrammar >> literalNodeClass [
	^ RMDLiteralNode
]

{ #category : #'parsers-expressions' }
RMDGrammar >> parenExpression [
	^ ($( asPParser , expression trimBlanks , $) asPParser) ==> #second
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
RMDGrammar >> propertyDefinition [
	^ (self delta / self variable , $' asPParser trimBlanks
		, '=' asPParser trimBlanks , expression)
		==> [ :quad | 
			self propertyDefinitionNodeClass
				variable: quad first
				expression: quad fourth ]
]

{ #category : #'class access' }
RMDGrammar >> propertyDefinitionNodeClass [
	^ RMDPropertyDefinitionNode
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
	^ ($[ asPParser trimBlanks
		,
			(((self unitFactor separatedBy: #blank asPParser plus)
				==> [ :array | (1 to: array size by: 2) collect: [ :i | array at: i ] ]
				,
					((($/ asPParser trimBlanks
						,
							((self unitFactor separatedBy: #blank asPParser plus)
								==> [ :array | (1 to: array size by: 2) collect: [ :i | array at: i ] ]))
						==> [ :pair | 
							pair second
								collect: [ :unitAndPow | 
									unitAndPow
										at: 2 put: unitAndPow second negated;
										yourself ] ]) optional
						==> [ :denominator | denominator ifNil: [ #() ] ]))
				==> [ :pair | pair first , pair second ]) optional
		, $] asPParser trimBlanks) ==> #second
]

{ #category : #'parsers-units' }
RMDGrammar >> unit [
	^ (self allUnits keys
		inject: #failure asPParser
		into: [ :p :s | p / s asPParser ]) flatten
]

{ #category : #'parsers-units' }
RMDGrammar >> unitFactor [
	^ (self unit
		,
			(($^ asPParser
				,
					(($- asPParser optional , #digit asPParser)
						==> [ :pair | 
							pair second asString asInteger
								* (pair first ifNil: [ 1 ] ifNotNil: [ -1 ]) ])) ==> #second)
				optional)
		==> [ :pair | 
			pair second ifNil: [ pair at: 2 put: 1 ].
			pair ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> utilityDefinition [
	^ (self variable , '=' asPParser trimBlanks , expression)
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
RMDGrammar >> variable [
	^ identifier ==> [ :symbol | self variableNodeClass identifier: symbol ]
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
