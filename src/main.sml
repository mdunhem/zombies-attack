structure Main =
struct
  datatype mode =
      HELP
    | BASIC_MODEL
    | WITH_LATENT_INFECTION
    | WITH_TREATMENT

  local
    fun go [] = HELP
      | go ("--help" :: _) = HELP
      | go ("--basic" :: _) = BASIC_MODEL
      | go ("--latent" :: _) = WITH_LATENT_INFECTION
      | go ("--treatment" :: _) = WITH_TREATMENT
      | go (_ :: _) = HELP
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
    "                 ~ Will you make it out alive?! ~               \n" ^
    "----------------------------------------------------------------\n" ^
    "                                                                \n"

  val helpMessage =
    banner ^
    "Usage                                               \n" ^
    "  zombies --basic                                   \n" ^
    "  zombies --latent                                  \n" ^
    "  zombies --quarantine                              \n" ^
    "  zombies --help                                    \n" ^
    "Options                                             \n" ^
    "  --basic       -     Run basic model               \n" ^
    "  --latent      -     Run latent infection model    \n" ^
    "  --treatment   -     Run with treatment model      \n" ^
    "  --help        -     Print this message            \n"


  fun toExitStatus b = if b then OS.Process.success else OS.Process.failure

  fun main (_, args) =
    let
      val (opts, _) = List.partition (String.isPrefix "--") args
      val mode = getMode opts
    in
      case mode of
           HELP => (print helpMessage; OS.Process.success)
         | BASIC_MODEL => (print banner; toExitStatus (Zombies.basic()))
         | WITH_LATENT_INFECTION => (print banner; toExitStatus (Zombies.latentInfection()))
         | WITH_TREATMENT => (print banner; toExitStatus (Zombies.withTreatment()))
    end
end
