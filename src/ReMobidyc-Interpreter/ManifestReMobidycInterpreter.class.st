"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestReMobidycInterpreter,
	#superclass : #PackageManifest,
	#category : #'ReMobidyc-Interpreter-Manifest'
}

{ #category : #'code-critics' }
ManifestReMobidycInterpreter class >> ruleAssignmentInIfTrueRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#RMDTypechecker #withSubject:object:do: #false)) #'2022-12-19T15:29:23.226843+09:00') )
]

{ #category : #'code-critics' }
ManifestReMobidycInterpreter class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'ManifestReMobidycInterpreter class' #ruleAssignmentInIfTrueRuleV1FalsePositive #true)) #'2022-12-19T15:38:44.129268+09:00') )
]

{ #category : #'code-critics' }
ManifestReMobidycInterpreter class >> ruleUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'ReMobidyc-Interpreter')) #'2022-12-19T15:27:22.804397+09:00') )
]
