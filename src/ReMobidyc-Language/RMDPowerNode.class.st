Class {
	#name : #RMDPowerNode,
	#superclass : #RMDNonAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDPowerNode >> evalIn: aRMDInterpreter [
	^ (expression1 evalIn: aRMDInterpreter)
		** (expression2 evalIn: aRMDInterpreter)
]

{ #category : #testing }
RMDPowerNode >> isPowerNode [
	^ true
]

{ #category : #accessing }
RMDPowerNode >> operator [
	^ '^'
]

{ #category : #accessing }
RMDPowerNode >> precedence [
	^ 2
]
