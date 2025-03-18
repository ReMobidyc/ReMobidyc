Extension { #name : 'RMDSimulationModel' }

{ #category : '*ReMobidyc-Chronicle' }
RMDSimulationModel >> recordInChronicle: aString [

	^ RMDChronicleStore recordModel: self folderName: aString
]
