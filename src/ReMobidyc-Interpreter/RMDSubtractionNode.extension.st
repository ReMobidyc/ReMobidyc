Extension { #name : #RMDSubtractionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSubtractionNode >> evalIn: aRMDInterpreter [

	^ (expression1 evalIn: aRMDInterpreter)
	  - (expression2 evalIn: aRMDInterpreter) ifNanOrInfinite: [ 
		  RMDNotComputableError signal: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDSubtractionNode >> typecheckIn: aRMDInterpreter [

	^ type := [
	          (expression1 typecheckIn: aRMDInterpreter) unify:
		          (expression2 typecheckIn: aRMDInterpreter) ]
		          on: RMDTypeUnificationError
		          do: [ :ex |
			          ex resignalAs: (RMDTypeError
					           on: self
					           subnode: expression1
					           type: ex type1
					           subnode: expression2
					           type: ex type2) ]
]
