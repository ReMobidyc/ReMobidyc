"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestReMobidycSpec',
	#superclass : 'PackageManifest',
	#category : 'ReMobidyc-Spec2-Manifest',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestReMobidycSpec class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#RMDSourcePresenterStyler)) #'2022-12-18T16:18:05.497507+09:00') #(#(#RGClassDefinition #(#RMDHighlightingSyntaxNodeTextInputPresenter)) #'2022-12-18T18:15:56.956264+09:00') )
]

{ #category : 'code-critics' }
ManifestReMobidycSpec class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'ReMobidyc-Spec2')) #'2022-12-15T16:09:18.614898+09:00') )
]

{ #category : 'code-critics' }
ManifestReMobidycSpec class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'ReMobidyc-Spec2')) #'2022-12-15T16:09:24.651374+09:00') )
]

{ #category : 'code-critics' }
ManifestReMobidycSpec class >> ruleExcessiveVariablesRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'ReMobidyc-Spec2')) #'2022-12-19T15:26:55.203251+09:00') )
]

{ #category : 'code-critics' }
ManifestReMobidycSpec class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestReMobidycSpec class' #ManifestReMobidycSpec)) #'2022-12-19T15:39:29.840783+09:00') )
]

{ #category : 'code-critics' }
ManifestReMobidycSpec class >> ruleLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#RMDTaskDefinitionBrowser #initializePresenters #false)) #'2022-12-19T15:29:05.020046+09:00') #(#(#RGMethodDefinition #(#RMDActionDefinitionBrowser #initializePresenters #false)) #'2022-12-19T15:38:59.782751+09:00') )
]

{ #category : 'code-critics' }
ManifestReMobidycSpec class >> ruleRBGlobalVariablesUsageV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'ReMobidyc-Spec2')) #'2020-07-11T16:59:54.685905+09:00') )
]
