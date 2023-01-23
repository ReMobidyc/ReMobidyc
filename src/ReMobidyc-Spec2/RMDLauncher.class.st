Class {
	#name : #RMDLauncher,
	#superclass : #RMDRepositoryModelsBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #operations }
RMDLauncher >> openModeller [
	self load ifNotNil: #open 
]
