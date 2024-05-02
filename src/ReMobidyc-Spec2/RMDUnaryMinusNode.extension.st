Extension { #name : 'RMDUnaryMinusNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDUnaryMinusNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode withAll: {
			  (RMDPrettyPrintText operator: self operator).
			  self expression asPrettyPrintNode }
]
