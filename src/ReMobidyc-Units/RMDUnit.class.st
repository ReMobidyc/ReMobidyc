Class {
	#name : #RMDUnit,
	#superclass : #Object,
	#classVars : [
		'KnownUnits'
	],
	#category : #'ReMobidyc-Units'
}

{ #category : #accessing }
RMDUnit class >> at: aString [
	^ KnownUnits at: aString ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDUnit class >> at: aString ifAbsent: errorBlock [
	^ KnownUnits at: aString ifAbsent: errorBlock
]

{ #category : #accessing }
RMDUnit class >> at: aString ifPresent: aBlock [
	^ KnownUnits at: aString ifPresent: aBlock
]

{ #category : #accessing }
RMDUnit class >> at: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ KnownUnits at: aString ifPresent: aBlock ifAbsent: errorBlock
]

{ #category : #constants }
RMDUnit class >> celsius [
	^ self at: 'C'
]

{ #category : #constants }
RMDUnit class >> day [
	^ self at: 'day'
]

{ #category : #constants }
RMDUnit class >> hour [
	^ self at: 'hour'
]

{ #category : #'class initialization' }
RMDUnit class >> initialize [
	<script: 'RMDProportionalUnitSymbol initialize'>
	| register m m2 m3 kg s kelvin n pa j w radian |
	KnownUnits ifNil: [ KnownUnits := Dictionary new ].
	KnownUnits removeAll.
	KnownUnits at: '' put: RMDCompoundUnit noDimension.
	register := [ :unit :variants | 
	KnownUnits at: unit symbol put: unit.
	variants do: [ :symbol | KnownUnits at: symbol asString put: unit ] ].
	"length"
	register value: (m := self newSISymbol: 'm') value: #().
	register
		value: (self newSymbol: 'Mm' scale: 1.0e6 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'km' scale: 1.0e3 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'cm' scale: 1.0e-2 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'mm' scale: 1.0e-3 siUnit: m)
		value: #().
	register
		value: (self newSymbol: 'µm' scale: 1.0e-6 siUnit: m)
		value: #('microm' 'micrometer').
	register
		value: (self newSymbol: 'mi' scale: 1609.344 siUnit: m)
		value: #(mile miles).
	register
		value: (self newSymbol: 'yd' scale: 0.9144 siUnit: m)
		value: #(yard yards).
	register
		value: (self newSymbol: 'ft' scale: 0.3048 siUnit: m)
		value: #(feet foot).
	register
		value: (self newSymbol: 'in' scale: 0.0254 siUnit: m)
		value: #(inch inches).
	"mass"
	register value: (kg := self newSISymbol: 'kg') value: #().
	register
		value: (self newSymbol: 't' scale: 1.0e3 siUnit: kg)
		value: #(Mg).
	register
		value: (self newSymbol: 'g' scale: 1.0e-3 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'mg' scale: 1.0e-6 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'µg' scale: 1.0e-9 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'lb' scale: 0.45359237 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'oz' scale: 0.028349523125 siUnit: kg)
		value: #().
	register
		value: (self newSymbol: 'gr' scale: 0.00006479891 siUnit: kg)
		value: #().
	"time"
	register value: (s := self newSISymbol: 's') value: #(sec secs s ss).
	register
		value: (self newSymbol: 'day' scale: 86400.0 siUnit: s)
		value: #('day' 'days').
	register
		value: (self newSymbol: 'h' scale: 3600.0 siUnit: s)
		value: #('hour' 'hours').
	register
		value: (self newSymbol: 'min' scale: 60.0 siUnit: s)
		value: #('mins' 'minute' 'minutes').
	register
		value: (self newSymbol: 'ms' scale: 1.0e-3 siUnit: s)
		value: #('msec').
	register
		value: (self newSymbol: 'µs' scale: 1.0e-6 siUnit: s)
		value: #('µsec' 'micros' 'micross').
	register
		value: (self newSymbol: 'week' scale: 604800.0 siUnit: s)
		value: #('w' 'weeks').
	register
		value: (self newSymbol: 'month' scale: 2592000.0 siUnit: s)
		value: #('mo' 'months' 'mo30' 'month30' 'months30').
	register
		value: (self newSymbol: 'month31' scale: 2678400.0 siUnit: s)
		value: #('mo31' 'months31').
	register
		value: (self newSymbol: 'year' scale: 31557600.0 siUnit: s)
		value: #('y' 'yr' 'a' 'years').
	"temperature"
	register value: (kelvin := self newSISymbol: 'K') value: #(K 'Kelvin').
	register
		value:
			(self
				newSymbol: '°C'
				fromSI: [ :t | t - 273.152519 ]
				toSI: [ :t | t + 273.152519 ]
				siUnit: kelvin)
		value: #('°C' '℃' 'DegreeC' 'Celsius').
	register
		value:
			(self
				newSymbol: '°F'
				fromSI: [ :t | t * 1.8 - 459.67 ]
				toSI: [ :t | (t + 459.67) / 1.8 ]
				siUnit: kelvin)
		value: #('F' '℉' 'DegreeF' 'Fahrenheit').
	"area"
	m2 := m * m.
	KnownUnits at: 'm2' put: m2.
	register
		value: (self newSymbol: 'ac' scale: 4046.8564224 siUnit: m2)
		value: #().
	register
		value: (self newSymbol: 'a' scale: 100.0 siUnit: m2)
		value: #().
	register
		value: (self newSymbol: 'ha' scale: 1.0e4 siUnit: m2)
		value: #().
	"volume"
	m3 := m2 * m.
	register
		value: (self newSymbol: 'Gl' scale: 1.0e6 siUnit: m3)
		value: #(GL Gℓ).
	register
		value: (self newSymbol: 'Ml' scale: 1.0e3 siUnit: m3)
		value: #(ML Mℓ).
	register
		value: (self newSymbol: 'kl' scale: 1.0 siUnit: m3)
		value: #(kL kℓ '㎘').
	register
		value: (self newSymbol: 'hl' scale: 1.0e-1 siUnit: m3)
		value: #(hL hℓ).
	register
		value: (self newSymbol: 'daL' scale: 1.0e-2 siUnit: m3)
		value: #(dal daℓ).
	register
		value: (self newSymbol: 'l' scale: 1.0e-3 siUnit: m3)
		value: #(L ℓ litre liter).
	register
		value: (self newSymbol: 'dl' scale: 1.0e-6 siUnit: m3)
		value: #(dL dℓ mL mℓ '㎖').
	register
		value: (self newSymbol: 'µl' scale: 1.0e-6 siUnit: m3)
		value: #(µL µℓ).
	"force"
	register
		value: (self newSymbol: 'N' scale: 1.0 siUnit: (n := kg * m / s / s))
		value: #().
	register
		value: (self newSymbol: 'kgf' scale: 9.8 siUnit: n)
		value: #().
	register
		value: (self newSymbol: 'dyn' scale: 1.0e-5 siUnit: n)
		value: #().
	register
		value: (self newSymbol: 'lbf' scale: 4.4482216152605 siUnit: n)
		value: #().
	register
		value: (self newSymbol: 'pdl' scale: 0.13825495437 siUnit: n)
		value: #().
	register
		value: (self newSymbol: 'sn' scale: 1.0e3 siUnit: n)
		value: #().
	"Pressure"
	register
		value: (self newSymbol: 'Pa' scale: 1.0 siUnit: (pa := n / m2))
		value: #().
	register
		value: (self newSymbol: 'daPa' scale: 1.0e1 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'hPa' scale: 1.0e2 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'kPa' scale: 1.0e3 siUnit: pa)
		value: #('pz').
	register
		value: (self newSymbol: 'MPa' scale: 1.0e6 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'GPa' scale: 1.0e9 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'dPa' scale: 1.0e-1 siUnit: pa)
		value: #('Ba' 'b').
	register
		value: (self newSymbol: 'cPa' scale: 1.0e-2 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'mPa' scale: 1.0e-3 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'μPa' scale: 1.0e-6 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'at' scale: 98066.5 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'psi' scale: 6894.757 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'Torr' scale: 133.322 siUnit: pa)
		value: #('mmHg').
	register
		value: (self newSymbol: 'atm' scale: 101325 siUnit: pa)
		value: #().
	register
		value: (self newSymbol: 'bar' scale: 100000 siUnit: pa)
		value: #().

	"Energy"
	register
		value: (self newSymbol: 'J' scale: 1.0 siUnit: (j := n * m))
		value: #().
	register
		value: (self newSymbol: 'cal' scale: 4.184 siUnit: j)
		value: #().
	register
		value: (self newSymbol: 'kcal' scale: 4.184e3 siUnit: j)
		value: #().
	"Power"
	register
		value: (self newSymbol: 'W' scale: 1.0 siUnit: (w := j / s))
		value: #('㍗').
	register
		value: (self newSymbol: 'kW' scale: 1.0e3 siUnit: w)
		value: #('㎾' '㌗').
	register
		value: (self newSymbol: 'MW' scale: 1.0e6 siUnit: w)
		value: #('㎿').
	register
		value: (self newSymbol: 'GW' scale: 1.0e9 siUnit: w)
		value: #().
	register
		value: (self newSymbol: 'mW' scale: 1.0e-3 siUnit: w)
		value: #('㎽').
	register
		value: (self newSymbol: 'μW' scale: 1.0e-6 siUnit: w)
		value: #('㎼').
	register
		value: (self newSymbol: 'nW' scale: 1.0e-9 siUnit: w)
		value: #('㎻').
	register
		value: (self newSymbol: 'pW' scale: 1.0e-12 siUnit: w)
		value: #('㎺').
	register
		value: (self newSymbol: 'PS' scale: 735.5 siUnit: w)
		value: #().
	register
		value: (self newSymbol: 'HP' scale: 745 siUnit: w)
		value: #('BHP' '㏋').
	"angle"
	register value: (radian := self newSISymbol: 'rad') value: #('㎭').
	register
		value: (self newSymbol: 'degree' scale: Float pi / 180.0 siUnit: radian)
		value: #('degrees' '°').
	register
		value: (self newSymbol: '%' scale: 1.0 - 2 siUnit: self noDimension)
		value: #('percent')
	"probability"
]

{ #category : #constants }
RMDUnit class >> kcal [
	^ self at: 'kcal'
]

{ #category : #constants }
RMDUnit class >> kg [
	^ self at: 'kg'
]

{ #category : #constants }
RMDUnit class >> m [
	^ self at: 'm'
]

{ #category : #constants }
RMDUnit class >> m2 [
	^ self at: 'm2'
]

{ #category : #constants }
RMDUnit class >> month [
	^ self at: 'month'
]

{ #category : #'instance creation' }
RMDUnit class >> newSISymbol: aString [
	^ RMDSIUnitSymbol newSISymbol: aString
]

{ #category : #'instance creation' }
RMDUnit class >> newSymbol: aString fromSI: fromNormalUnitBlock toSI: toNormalUnitBlock siUnit: aRMDUnit [
	^ RMDNonProportionalUnitSymbol
		newSymbol: aString
		fromSI: fromNormalUnitBlock
		toSI: toNormalUnitBlock
		siUnit: aRMDUnit
]

{ #category : #'instance creation' }
RMDUnit class >> newSymbol: aString scale: aFloat siUnit: aRMDUnit [
	^ RMDProportionalUnitSymbol
		newSymbol: aString
		scale: aFloat
		siUnit: aRMDUnit
]

{ #category : #constants }
RMDUnit class >> noDimension [
	^ self at: ''
]

{ #category : #constants }
RMDUnit class >> rad [
	^ self at: 'rad'
]

{ #category : #constants }
RMDUnit class >> s [
	^ self at: 's'
]

{ #category : #constants }
RMDUnit class >> week [
	^ self at: 'week'
]

{ #category : #constants }
RMDUnit class >> year [
	^ self at: 'year'
]

{ #category : #arithmetics }
RMDUnit >> * aRMDUnit [
	^ self subclassResponsibility
]

{ #category : #arithmetics }
RMDUnit >> ** anInteger [
	^ self subclassResponsibility
]

{ #category : #arithmetics }
RMDUnit >> / aRMDUnit [
	^ self subclassResponsibility
]

{ #category : #'error signalling' }
RMDUnit >> conversionError: aString [
	^ RMDUnitConversionError signal: aString
]

{ #category : #conversions }
RMDUnit >> fromSI: aNumber [
	^ self subclassResponsibility
]

{ #category : #testing }
RMDUnit >> hasDimension [
	^ true
]

{ #category : #testing }
RMDUnit >> isCompound [
	^ self subclassResponsibility
]

{ #category : #testing }
RMDUnit >> isLength [

	^ self siUnit = RMDUnit m
]

{ #category : #testing }
RMDUnit >> isProportional [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDUnit >> siUnit [
	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDUnit >> symbolsAndOrdersDo: aBlock [
	^ self subclassResponsibility
]

{ #category : #conversions }
RMDUnit >> toSI: aNumber [
	^ self subclassResponsibility
]
