structure Main =
struct
  datatype mode =
      PRINT_DEVELOPMENT
    | HELP
    | BASIC_MODEL
    | WITH_LATENT_INFECTION
    | WITH_QUARANTINE
    (*| WITH_TREATMENT
    | WITH_IMPULSIVE_ERADICATION*)

  local
    fun go [] = PRINT_DEVELOPMENT
      | go ("--help" :: _) = HELP
      | go ("--basic" :: _) = BASIC_MODEL
      | go ("--latent" :: _) = WITH_LATENT_INFECTION
      | go ("--quarantine" :: _) = WITH_QUARANTINE
  in
    fun getMode args = go args
  end

  val banner =
    "----------------------------------------------------------------\n" ^
    "        CS 355 - Mike Dunhem - Project 1 - Zombies Attack!      \n" ^
    "  ########  #######  ##     ## ########  #### ########  ######  \n" ^
    "       ##  ##     ## ###   ### ##     ##  ##  ##       ##    ## \n" ^
    "      ##   ##     ## #### #### ##     ##  ##  ##       ##       \n" ^
    "     ##    ##     ## ## ### ## ########   ##  ######    ######  \n" ^
    "    ##     ##     ## ##     ## ##     ##  ##  ##             ## \n" ^
    "   ##      ##     ## ##     ## ##     ##  ##  ##       ##    ## \n" ^
    "  ########  #######  ##     ## ########  #### ########  ######  \n" ^
    "                  ~ Will you make out alive?! ~                 \n" ^
    "----------------------------------------------------------------\n" ^
    "                                                                \n"

  val helpMessage =
    banner ^
    "Usage                                    \n" ^
    "  zombies --basic                        \n" ^
    "  zombies --latent                       \n" ^
    "  zombies --quarantine                   \n" ^
    "  zombies --help                         \n" ^
    "Options                                  \n" ^
    "  --basic       -     Run basic model    \n" ^
    "  --latent      -     Run basic model    \n" ^
    "  --quarantine  -     Run basic model    \n" ^
    "  --help        -     Print this message \n"


  fun toExitStatus b = if b then OS.Process.success else OS.Process.failure

  fun main (_, args) =
    let
      val (opts, files) = List.partition (String.isPrefix "--") args
      val mode = getMode opts
    in
      case mode of
           PRINT_DEVELOPMENT => (print helpMessage; OS.Process.success)
         | HELP => (print helpMessage; OS.Process.success)
         | BASIC_MODEL => (print banner; toExitStatus (Zombie.basic()))
         | WITH_LATENT_INFECTION => (print banner; toExitStatus (Zombie.latentInfection()))
         | WITH_QUARANTINE => (print banner; toExitStatus (Zombie.quarantine()))
    end
end
