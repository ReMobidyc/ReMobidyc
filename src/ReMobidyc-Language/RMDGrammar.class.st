Class {
	#name : #RMDGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'delta',
		'variable',
		'unit',
		'type',
		'expression',
		'identifier'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'class access' }
RMDGrammar >> additionNodeClass [
	^ RMDAdditionNode
]

{ #category : #'class access' }
RMDGrammar >> additiveDefinitionNodeClass [
	^ RMDAdditiveDefinitionNode
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

{ #category : #'parsers-definitions' }
RMDGrammar >> definition [
	^ (variable / delta , type optional
		, ('=' asPParser / '<+' asPParser / '<*' asPParser) trimBlanks
		, expression)
		==> [ :quad | 
			(self definitionNodeFor: quad third)
				variable: quad first
				type: quad second
				expression: quad fourth ]
]

{ #category : #'parsers-definitions' }
RMDGrammar >> definitionNodeFor: aString [
	aString = '='
		ifTrue: [ ^ self directDefinitionNodeClass ].
	aString = '<+'
		ifTrue: [ ^ self additiveDefinitionNodeClass ].
	aString = '<*'
		ifTrue: [ ^ self productiveDefinitionNodeClass ].
	^ self error: 'Unknown assignment operator: ' , aString
]

{ #category : #'parsers-atoms' }
RMDGrammar >> delta [
	^ ('delta' asPParser / 'Δ' asPParser , #blank asPParser plus
		, identifier)
		==> [ :triple | self deltaNodeClass symbol: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> deltaNodeClass [
	^ RMDDeltaNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential [
	^ ('d/dt' asPParser , #blank asPParser plus , identifier)
		==> [ :triple | self differentialNodeClass symbol: triple third ]
]

{ #category : #'parsers-atoms' }
RMDGrammar >> differential2 [
	^ ('d2/dt2' asPParser / 'd^2/dt^2' asPParser , #blank asPParser plus
		, identifier)
		==> [ :triple | self differential2NodeClass symbol: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> differential2NodeClass [
	^ RMDDifferential2Node
]

{ #category : #'class access' }
RMDGrammar >> differentialNodeClass [
	^ RMDDifferentialNode
]

{ #category : #'class access' }
RMDGrammar >> directDefinitionNodeClass [
	^ RMDDirectDefinitionNode
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
	^ self parenExpression / self apply / self old / self differential / self differential2 / delta
		/ variable / self literal
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

{ #category : #'class access' }
RMDGrammar >> fractionNodeClass [
	^ RMDFractionNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> identifier [
	^ (#letter asPParser
		, (#letter asPParser / #digit asPParser / $_ asPParser) star)
		flatten
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
	^ ($- asPParser optional , #digit asPParser plus
		, ($. asPParser , #digit asPParser plus) optional) flatten
		==> [ :numeric | self literalNodeClass literal: numeric ]
]

{ #category : #'class access' }
RMDGrammar >> literalNodeClass [
	^ RMDLiteralNode
]

{ #category : #'parsers-atoms' }
RMDGrammar >> old [
	^ ('old' asPParser , #blank asPParser plus , identifier)
		==> [ :triple | self oldNodeClass symbol: triple third ]
]

{ #category : #'class access' }
RMDGrammar >> oldNodeClass [
	^ RMDOldNode
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

{ #category : #'class access' }
RMDGrammar >> productiveDefinitionNodeClass [
	^ RMDProductiveDefinitionNode
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
			((self unitFactor separatedBy: #blank asPParser plus)
				==> [ :array | (1 to: array size by: 2) collect: [ :i | array at: i ] ])
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
				==> [ :denominator | denominator ifNil: [ #() ] ])
		, $] asPParser trimBlanks) ==> [ :quad | quad second , quad third ]
]

{ #category : #'parsers-units' }
RMDGrammar >> unit [
	^ (self allUnits keys
		inject: #failure asPParser
		into: [ :p :s | p / s asPParser ]) flatten
]

{ #category : #'parsers-units' }
RMDGrammar >> unitFactor [
	^ (unit
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

{ #category : #'parsers-atoms' }
RMDGrammar >> variable [
	^ identifier ==> [ :symbol | self variableNodeClass symbol: symbol ]
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
