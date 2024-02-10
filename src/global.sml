signature GLOBAL =
sig

  type result = OS.Process.status

  exception Error of string * result

  val reqPath : string
  val submitPath : string

  val course : string
  val administrators : string
  val submissionEmail : string

  val msgCheckRegistered : string
  val msgCheckAccess : string
  val msgContactAdmin : string

  val exitOK             : result
  val exitInternalError  : result
  val exitSysError       : result
  val exitCmdLine        : result
  val exitParsing        : result
  val exitProofInvalid   : result
  val exitUnjustified    : result
  val exitWrongGoal      : result
  val exitTermCheck      : result
  val exitSpec           : result
  val exitSpecIncomplete : result
  val exitSubmission     : result

  val exitMin  : result * result -> result
  val isExitOK : result -> bool

end (* signature GLOBAL *)

structure Global :> GLOBAL =
struct

  type result = OS.Process.status

  exception Error of string * result

  val reqPath = "/afs/andrew.cmu.edu/scs/cs/15-399/req/"
  val submitPath = "/afs/andrew.cmu.edu/scs/cs/15-399/submit/"

  val course = "15-399"
  val administrators = "abel@cs.cmu.edu or awodey@andrew.cmu.edu"
  val submissionEmail = "abel@cs.cmu.edu AND awodey@andrew.cmu.edu"

  val msgCheckRegistered =
    "- you are registered student of course " ^ course ^ "\n" ^
    "- you registered with your Andrew ID for this course\n"
  val msgCheckAccess =
    "- your Kerberos tickets are not expired\n" ^
    "- you have access to the Andrew File System (/afs/andrew.cmu.edu) from your\n" ^
    "  machine right now\n"
  val msgContactAdmin =
    "If you made sure the fault is not on your side, please contact the course\n" ^
    "administrators now (" ^ administrators ^").\n" ^
    "Please supply the error message above, your Andrew ID and the command line.\n"

(* Andreas, 2024-02-10, the new standard library makes OS.Process.status abstract,
   so we cannot easily construct specific exit codes.
   One could try to use Posix.Process, but let's not go there...

  val exitOK = 0                   (* OK                                *)
  val exitInternalError = 1        (* uncaught exception, bug in Tutch  *)
  val exitSysError = 2             (* file not found, access denied etc *)
  val exitCmdLine = 3              (* invalid command line syntax       *)
  val exitParsing = 4              (* lexing or parsing error           *)
  val exitProofInvalid = 5         (* proof malformed, like [A;[B;B]]   *)
  val exitUnjustified = 6          (* proof contains unjustified lines  *)
  val exitWrongGoal = 7            (* goal does not match proof         *)
  val exitSpec = 8                 (* requirements file not found       *)
  val exitSpecIncomplete = 9       (* not all req. solved               *)
  val exitSubmission = 10          (* submission failed                 *)
  val exitTermCheck = 11           (* term does not check               *)

  fun exitMin (0, status) = status
    | exitMin (status, 0) = status
    | exitMin (status, status') = Int.min (status, status')
*)

  val fail = OS.Process.failure

  val exitOK = OS.Process.success  (* OK                                *)
  val exitInternalError = fail     (* uncaught exception, bug in Tutch  *)
  val exitSysError = fail          (* file not found, access denied etc *)
  val exitCmdLine = fail           (* invalid command line syntax       *)
  val exitParsing = fail           (* lexing or parsing error           *)
  val exitProofInvalid = fail      (* proof malformed, like [A;[B;B]]   *)
  val exitUnjustified = fail       (* proof contains unjustified lines  *)
  val exitWrongGoal = fail         (* goal does not match proof         *)
  val exitSpec = fail              (* requirements file not found       *)
  val exitSpecIncomplete = fail    (* not all req. solved               *)
  val exitSubmission = fail        (* submission failed                 *)
  val exitTermCheck = fail         (* term does not check               *)

  (* Return success if both statuses are success. *)
  fun exitMin (status1, status2) =
    if OS.Process.isSuccess status1 then status2 else status1

  val isExitOK = OS.Process.isSuccess

end (* structure GLOBAL *)
