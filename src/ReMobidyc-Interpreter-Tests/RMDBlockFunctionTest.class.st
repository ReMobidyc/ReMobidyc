Class {
	#name : #RMDBlockFunctionTest,
	#superclass : #TestCase,
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #tests }
RMDBlockFunctionTest >> testValue [
	| f |
	f := RMDBlockFunction block: [ :x | x ].
	self assert: (f value: 10) equals: 10.
	f := RMDBlockFunction block: [ :x :y | x ].
	self should: [ f value: 10 ] raise: RMDNumArgsError
]

{ #category : #tests }
RMDBlockFunctionTest >> testValueValue [
	| f |
	f := RMDBlockFunction block: [ :x :y | x ].
	self assert: (f value: 10 value: 20) equals: 10.
	f := RMDBlockFunction block: [ :x | x ].
	self should: [ f value: 10 value: 20 ] raise: RMDNumArgsError
]

{ #category : #tests }
RMDBlockFunctionTest >> testValueValueValue [
	| f |
	f := RMDBlockFunction block: [ :x :y :z | x ].
	self assert: (f value: 10 value: 20 value: 30) equals: 10.
	f := RMDBlockFunction block: [ :x | x ].
	self should: [ f value: 10 value: 20 value: 30] raise: RMDNumArgsError
]

{ #category : #tests }
RMDBlockFunctionTest >> testValueValueValueValue [
	| f |
	f := RMDBlockFunction block: [ :x :y :z :w | x ].
	self assert: (f value: 10 value: 20 value: 30 value: 40) equals: 10.
	f := RMDBlockFunction block: [ :x | x ].
	self should: [ f value: 10 value: 20 value: 30 value: 40] raise: RMDNumArgsError
]

{ #category : #tests }
RMDBlockFunctionTest >> testValueWithArguments [
	| f |
	f := RMDBlockFunction block: [ :x :y :z | x ].
	self assert: (f valueWithArguments: {10 . 20 . 30}) equals: 10.
	self should: [ f valueWithArguments: {10} ] raise: RMDNumArgsError.
	self
		should: [ f valueWithArguments: {10 . 20} ]
		raise: RMDNumArgsError.
	self
		should: [ f valueWithArguments: {10 . 20 . 30 . 40} ]
		raise: RMDNumArgsError
]
