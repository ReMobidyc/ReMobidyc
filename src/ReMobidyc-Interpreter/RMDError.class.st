Class {
	#name : 'RMDError',
	#superclass : 'Exception',
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'private' }
RMDError >> composeMessageText [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDError >> defaultAction [

	^ UnhandledError signalForException: self
]

{ #category : 'accessing' }
RMDError >> messageText [

	^ messageText ifNil: [ messageText := self composeMessageText ]
]
