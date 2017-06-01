structure Zombies =
struct

  fun basic () =
    let
      val basicModel = BasicModel.run ()
    in
      (
        BasicModel.printOutput(basicModel);
        true
      )
    end

  fun latentInfection () =
    let
      val basicModel = LatentInfection.run ()
    in
      (
        LatentInfection.printOutput basicModel;
        true
      )
    end

  fun quarantine () =
    let
      val sampleOutput = "Running basic model with quarantine"
    in
      (print sampleOutput; true)
    end

end
