(* $Id: cxt.sml,v 1.1 2000/10/17 22:23:08 abel Exp $ *)

signature CXT =
sig

(* It would be good to hide the internal representation of contexts.
   However, this would require too many changes for now, since Val.Env
   is also defined via Cxt.  The best solution is to always bundle a
   context with an environment, then the environment maps named
   variables to generic values (integers), and the context integers to
   entries (e.g., types).  This solves all shadowing and
   alpha-problems cleanly (see, e.g., Abel/Coquand/Dybjer, MPC'08).

   abel, 2009-02-11

  type 'a Cxt
 *)

  datatype 'a Cxt =
      Empty
    | Ext of string * 'a * 'a Cxt

  val empty : 'a Cxt
  val ext   : string * 'a * 'a Cxt -> 'a Cxt

  val lookup : string * 'a Cxt -> 'a option
  val length : 'a Cxt -> int

end (* signature CXT *)

structure Cxt :> CXT =
struct

  datatype 'a Cxt =
      Empty
    | Ext of string * 'a * 'a Cxt

  fun lookup (x, Empty) = NONE
    | lookup (x, Ext (y, A, G)) = if x=y then SOME A else lookup (x, G)

  fun length (Empty) = 0
    | length (Ext (x, A, G)) = 1 + length (G)

  val empty = Empty

  (* avoid shadowing! *)
  fun ext (x, a, G) = case lookup (x, G) of
      NONE => Ext (x, a, G)
    | SOME _ => raise (Global.Error ("Identifier " ^ x ^ " already bound in context.", Global.exitProofInvalid))

end (* structure Cxt *)
