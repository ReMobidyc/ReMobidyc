Class {
	#name : 'RMDRuntimeError',
	#superclass : 'RMDSemanticError',
	#instVars : [
		'interpreter'
	],
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'testing' }
RMDRuntimeError class >> isAbstract [

	^ self = RMDRuntimeError
]

{ #category : 'accessing' }
RMDRuntimeError >> findInterpreter [

	| context |
	context := signalContext.
	[ context notNil ] whileTrue: [
		(context receiver isKindOf: RMDInterpreter) ifTrue: [
			^ context receiver ].
		context := context sender ].
	^ nil
]

{ #category : 'accessing' }
RMDRuntimeError >> interpreter [

	^ interpreter ifNil: [ interpreter := self findInterpreter ]
]

{ #category : 'accessing' }
RMDRuntimeError >> interpreter: aRMDInterpreter [

	interpreter := aRMDInterpreter
]
