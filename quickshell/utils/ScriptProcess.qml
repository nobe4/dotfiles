import Quickshell
import Quickshell.Io

Process {
    id: root

    required property string script
    property list<string> scriptArgs: []

    command: ["bash", Quickshell.shellPath(root.script)].concat(root.scriptArgs)
}
