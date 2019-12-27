Class {
	#name : #RMDGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'modifier',
		'variable',
		'unit',
		'type',
		'literal',
		'atom',
		'function',
		'call'
	],
	#category : #'ReMobidyc-Language'
}

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

{ #category : #parsers }
RMDGrammar >> atom [
	^ #failure asPParser
]

{ #category : #parsers }
RMDGrammar >> call [
	^ #failure asPParser
]

{ #category : #parsers }
RMDGrammar >> definition [
	^ #failure asPParser
]

{ #category : #units }
RMDGrammar >> energyUnits [
	^ {('J' -> #(1.0 nil 'J')).
	('kJ' -> #(1000.0 nil 'J')).
	('kcal' -> #(4184.0 nil 'J')).
	('cal' -> #(4.184 nil 'J'))} asDictionary
]

{ #category : #parsers }
RMDGrammar >> function [
	^ #failure asPParser
]

{ #category : #units }
RMDGrammar >> lengthUnits [
	^ {('km' -> #(1000.0 nil 'm')).
	('m' -> #(1.0 nil 'm')).
	('cm' -> #(0.01 nil 'm')).
	('mm' -> #(0.001 nil 'm'))} asDictionary
]

{ #category : #parsers }
RMDGrammar >> literal [
	^ #failure asPParser
]

{ #category : #parsers }
RMDGrammar >> modifier [
	^ ('delta' asPParser / 'd/dt' asPParser / 'd2/dt2' asPParser
		/ 'old' asPParser , #blank asPParser) ==> #first
]

{ #category : #accessing }
RMDGrammar >> start [
	"Answer the production to start this parser with."
	
	self definition
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

{ #category : #parsers }
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

{ #category : #parsers }
RMDGrammar >> unit [
	^ (self allUnits keys
		inject: #failure asPParser
		into: [ :p :s | p / s asPParser ]) flatten
]

{ #category : #parsers }
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

{ #category : #parsers }
RMDGrammar >> variable [
	^ (#letter asPParser
		, (#letter asPParser / #digit asPParser / $_ asPParser) star)
		flatten
]

{ #category : #units }
RMDGrammar >> weightUnits [
	^ {('t' -> #(1000 nil 'kg')).
	('kg' -> #(1 nil 'kg')).
	('g' -> #(0.001 nil 'kg')).
	('mg' -> #(0.000001 nil 'kg'))} asDictionary
]
