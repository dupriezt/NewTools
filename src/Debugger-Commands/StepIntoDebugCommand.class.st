Class {
	#name : #StepIntoDebugCommand,
	#superclass : #DebugCommand,
	#category : #'Debugger-Commands'
}

{ #category : #default }
<<<<<<< HEAD
StepIntoDebugCommand class >> defaultCommandName [
	<toolbarDebugCommand: 1>
	
	^ 'Into'
]

{ #category : #default }
=======
>>>>>>> upstream/master
StepIntoDebugCommand class >> defaultDescription [
	^ 'Step in the highlighted message, i.e. follow the sent message, taking debugger control in the method invoked.'
]

{ #category : #initialization }
StepIntoDebugCommand class >> defaultIconName [
	^ #glamorousInto
]

{ #category : #default }
StepIntoDebugCommand class >> defaultName [
<<<<<<< HEAD
=======
	<toolbarDebugCommand: 20>
>>>>>>> upstream/master
	
	^ 'Into'
]

{ #category : #initialization }
StepIntoDebugCommand class >> defaultShortcut [
	^ PharoShortcuts current stepIntoShortcut
]

{ #category : #hooks }
StepIntoDebugCommand >> execute [
	self session stepInto: self currentContext
]
