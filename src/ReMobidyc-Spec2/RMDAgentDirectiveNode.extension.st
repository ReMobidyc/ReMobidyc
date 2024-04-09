Extension { #name : #RMDAgentDirectiveNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDAgentDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: self directiveName
		  agent: self agentIdentifier
]
