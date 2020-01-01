Class {
	#name : #RMDPowerNode,
	#superclass : #RMDNonAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

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
