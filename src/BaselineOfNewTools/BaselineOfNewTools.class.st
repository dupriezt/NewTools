Class {
	#name : #BaselineOfNewTools,
	#superclass : #BaselineOf,
	#category : #BaselineOfNewTools
}

{ #category : #baselines }
BaselineOfNewTools >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
			
		self
			taskit: spec;
			sindarin: spec.

		spec
			package: 'NewTools-Core';
			package: 'NewTools-Morphic';
			package: 'NewTools-Gtk';
			"inspector"
			package: 'NewTools-Inspector-Extensions' with: [ spec requires: #('NewTools-Core') ];
			package: 'NewTools-Inspector' with: [ spec requires: #( 'NewTools-Inspector-Extensions') ];
			"playground"
			package: 'NewTools-Playground' with: [ spec requires: #('NewTools-Inspector') ];
			"browser"
			package: 'NewTools-SystemBrowser' with: [ spec requires: #('NewTools-Inspector') ];
			"debugger"
			package: 'Debugger-Commands';
			package: 'NewTools-Debugger' with: [ spec requires: #('NewTools-Inspector' 'Debugger-Commands') ];
			package: 'NewTools-Debugger-Extensions';
			package: 'NewTools-Debugger-Tests' with: [ spec requires: #('NewTools-Debugger') ];
			"extras"
			package: 'HelpCenter' with: [ spec requires: #('NewTools-Core') ];
			package: 'NewTools-FlagBrowser' with: [ spec requires: #('NewTools-Core') ];
			package: 'NewTools-FlagBrowser-Tests' with: [ spec requires: #('NewTools-FlagBrowser') ];
<<<<<<< HEAD
			package: 'NewTools-Sindarin-Tools' with: [ spec requires: #('NewTools-FlagBrowser-Tests') ];
			package: 'NewTools-DebuggerSelector' with: [ spec requires: #('NewTools-Sindarin-Tools') ];
			package: 'NewTools-DebuggerSelector-Tests' with: [ spec requires: #('NewTools-DebuggerSelector') ]]
]

{ #category : #baselines }
BaselineOfNewTools >> commander: spec [

"	spec baseline: 'Commander2' with: [ spec repository: 'github://pharo-spec/Commander2:v1.2.0/src']"
	spec baseline: 'Commander2' with: [ spec repository: 'github://pharo-spec/Commander2:ad5041cccdd34a7b021ca505323ce6d9a5912480/src']
=======
			"package: 'NewTools-FileDialog' with: [ spec requires: #('NewTools-Core') ];
			package: 'NewTools-FileDialog-Tests' with: [ spec requires: #('NewTools-FileDialog') ];"
			package: 'NewTools-Sindarin-Tools' with: [ spec requires: #('NewTools-FlagBrowser-Tests') ].
			
		]
>>>>>>> upstream/master
]

{ #category : #dependencies }
BaselineOfNewTools >> sindarin: spec [

	spec 
		baseline: 'Sindarin' 
		with: [ spec repository: 'github://dupriezt/ScriptableDebugger' ]
]

{ #category : #dependencies }
<<<<<<< HEAD
BaselineOfNewTools >> spec: spec [
	"Depends on a specific commit of Spec2 to avoid breaking changes done to styles"
	spec 
		baseline: 'Spec2' 
		with: [ spec repository: 'github://pharo-spec/Spec:daf4020f5fc97c3fc3a5b069dcdf3195e5af18cb/src' ]
=======
BaselineOfNewTools >> taskit: spec [

	spec 
		baseline: 'TaskIt' 
		with: [ spec repository: 'github://sbragagnolo/taskit' ]
>>>>>>> upstream/master
]
