Class {
	#name : #ProceedDebugCommand,
	#superclass : #DebugCommand,
	#category : #'Debugger-Commands'
}

{ #category : #default }
<<<<<<< HEAD
ProceedDebugCommand class >> defaultCommandName [
	<toolbarDebugCommand: 1000>
	^ 'Proceed'
]

{ #category : #default }
=======
>>>>>>> upstream/master
ProceedDebugCommand class >> defaultDescription [
	^ 'Relinquish debugger control and proceed execution from the current point of debugger control.'
]

{ #category : #initialization }
ProceedDebugCommand class >> defaultIconName [
	^ #glamorousGo
]

{ #category : #default }
ProceedDebugCommand class >> defaultName [
<<<<<<< HEAD

=======
	<toolbarDebugCommand: 10>
>>>>>>> upstream/master
	^ 'Proceed'
]

{ #category : #initialization }
ProceedDebugCommand class >> defaultShortcut [
	^ PharoShortcuts current resumeExecutionShortcut
]

{ #category : #hooks }
ProceedDebugCommand >> execute [
	self session
		resume;
		clear.
	self debugger close
]
