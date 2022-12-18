Class {
	#name : #RMDError,
	#superclass : #Exception,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #private }
RMDError >> composeMessageText [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDError >> defaultAction [

	^ UnhandledError signalForException: self
]

{ #category : #accessing }
RMDError >> messageText [

	^ messageText ifNil: [ messageText := self composeMessageText ]
]
