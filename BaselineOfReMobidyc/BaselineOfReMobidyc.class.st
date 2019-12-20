Class {
	#name : #BaselineOfReMobidyc,
	#superclass : #BaselineOf,
	#category : 'BaselineOfReMobidyc'
}

{ #category : #baselines }
BaselineOfReMobidyc >> baselineOf: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'P3'
				with: [ spec repository: 'github://svenvc/P3:master/repository' ].
			spec
				baseline: 'NeoJSON'
				with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ].
			spec
				baseline: 'ZTimestamp'
				with: [ spec repository: 'github://svenvc/ztimestamp:master/repository' ].
			spec
				baseline: 'Glorp'
				with: [ spec repository: 'github://pharo-rdbms/glorp:master/' ].
			spec group: 'default' with: #('core').
			spec group: 'core' with: #('ReMobidyc-Storage') ]
]
