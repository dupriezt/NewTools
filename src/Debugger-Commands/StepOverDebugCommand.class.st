Class {
	#name : #StepOverDebugCommand,
	#superclass : #DebugCommand,
	#category : #'Debugger-Commands'
}

{ #category : #accessing }
<<<<<<< HEAD
StepOverDebugCommand class >> defaultCommandName [
	<toolbarDebugCommand: 2>

	^ 'Over'
]

{ #category : #accessing }
=======
>>>>>>> upstream/master
StepOverDebugCommand class >> defaultDescription [
	^'Step over the highlighted message, i.e. do not follow the sent message, taking debugger control after the method invoked returns.'
]

{ #category : #initialization }
StepOverDebugCommand class >> defaultIconName [
	^ #glamorousOver
]

{ #category : #accessing }
StepOverDebugCommand class >> defaultName [
<<<<<<< HEAD
=======
	<toolbarDebugCommand: 40>
>>>>>>> upstream/master

	^ 'Over'
]

{ #category : #initialization }
StepOverDebugCommand class >> defaultShortcut [
	^ PharoShortcuts current stepOverShortcut
]

{ #category : #hooks }
StepOverDebugCommand >> execute [
	self session stepOver: self currentContext
]
