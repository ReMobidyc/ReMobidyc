Extension { #name : #RMDScriptNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDScriptNodeTest >> testEvalIn [
	| script |
	script := RMDGrammar new script
		parse:
			'to metabolize is
    my delta energy'' = basal_metabolism * -1
where
    basal_metabolism = 1500 [kcal/day]'.
	interpreter context script: script.
	interpreter context setMemoryAddressFor: 'energy' agent: nil to: 1.
	interpreter memory
		nextAt: 1 put: 100;
		tick.
	script evalIn: interpreter.
	interpreter memory tick.
	self
		assert: (interpreter readVariable: 'energy' agent: nil ifAbsent: [ nil ])
		closeTo: 100 - ('kcal' asRMDUnit / 'day' asRMDUnit toSI: 1500)
]
