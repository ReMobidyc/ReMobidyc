"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestReMobidycLanguage,
	#superclass : #PackageManifest,
	#category : #'ReMobidyc-Language-Manifest'
}

{ #category : #'code-critics' }
ManifestReMobidycLanguage class >> ruleUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'ReMobidyc-Language')) #'2022-12-18T12:00:52.179437+09:00') )
]
