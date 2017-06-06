structure Main =
struct
  datatype mode =
      HELP
    | BASIC_MODEL
    | WITH_LATENT_INFECTION
    | WITH_TREATMENT

  local

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
      "Loading from SML Interpreter Usage                  \n" ^
      "  Main.run \"basic\"                                \n" ^
      "  Main.run \"latent\"                               \n" ^
      "  Main.run \"treatment\"                            \n" ^
      "  Main.run \"help\"                                 \n" ^
      "                                                    \n" ^
      "Executable Usage                                    \n" ^
      "  ./bin/zombies basic                               \n" ^
      "  ./bin/zombies latent                              \n" ^
      "  ./bin/zombies treatment                           \n" ^
      "  ./bin/zombies help                                \n" ^
      "                                                    \n" ^
      "Options                                             \n" ^
      "  basic       -     Run basic model                 \n" ^
      "  latent      -     Run latent infection model      \n" ^
      "  treatment   -     Run with treatment model        \n" ^
      "  help        -     Print this message              \n"

    fun getMode [] = HELP
      | getMode ("help" :: _) = HELP
      | getMode ("basic" :: _) = BASIC_MODEL
      | getMode ("latent" :: _) = WITH_LATENT_INFECTION
      | getMode ("treatment" :: _) = WITH_TREATMENT
      | getMode (_ :: _) = HELP

    fun runMode mode =
      case getMode mode of
           HELP => (print helpMessage; OS.Process.success)
         | BASIC_MODEL => (
            print banner;
            BasicModel.printOutput(BasicModel.run());
            OS.Process.success
           )
         | WITH_LATENT_INFECTION => (
            print banner;
            LatentInfection.printOutput(LatentInfection.run());
            OS.Process.success
           )
         | WITH_TREATMENT => (
            print banner;
            WithTreatmentModel.printOutput(WithTreatmentModel.run());
            OS.Process.success
           )
  in

    fun run mode = runMode(mode :: [])

    fun main (_, args) = runMode args

  end
end
