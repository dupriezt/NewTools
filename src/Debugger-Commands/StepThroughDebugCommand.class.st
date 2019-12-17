Class {
	#name : #StepThroughDebugCommand,
	#superclass : #DebugCommand,
	#category : #'Debugger-Commands'
}

{ #category : #default }
<<<<<<< HEAD
StepThroughDebugCommand class >> defaultCommandName [
	<toolbarDebugCommand: 3>

	^ 'Through'
]

{ #category : #default }
=======
>>>>>>> upstream/master
StepThroughDebugCommand class >> defaultDescription [
	^ 'Step over the highlighted message, i.e. do not follow the sent message, taking debugger control after the method invoked returns or whenever execution should return inside a block used as an argument before that.'
]

{ #category : #initialization }
StepThroughDebugCommand class >> defaultIconName [
	^ #glamorousThrough 
]

{ #category : #default }
StepThroughDebugCommand class >> defaultName [
<<<<<<< HEAD
=======
	<toolbarDebugCommand: 30>
>>>>>>> upstream/master

	^ 'Through'
]

{ #category : #initialization }
StepThroughDebugCommand class >> defaultShortcut [
	^ PharoShortcuts current stepThroughShortcut
]

{ #category : #hooks }
StepThroughDebugCommand >> execute [
	self session stepThrough: self currentContext
]
