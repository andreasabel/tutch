(* Entry point for binary created by MLton *)

val self = CommandLine.name()
val args = CommandLine.arguments()

val result = Top.top (self, args)
val _ = OS.Process.exit result

