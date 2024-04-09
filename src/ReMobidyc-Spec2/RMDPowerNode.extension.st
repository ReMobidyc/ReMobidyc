Extension { #name : #RMDPowerNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDPowerNode >> asPrettyPrintNode [

	^ self expression asPrettyPrintNode ** self order
]
