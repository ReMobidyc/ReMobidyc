Extension { #name : 'RMDRemainderNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDRemainderNode >> evalIn: aRMDInterpreter [

	^ (expression1 evalIn: aRMDInterpreter)
	  % (expression2 evalIn: aRMDInterpreter) ifNanOrInfinite: [
		  RMDNotComputableError signal: self ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDRemainderNode >> typecheckIn: aRMDInterpreter [

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
