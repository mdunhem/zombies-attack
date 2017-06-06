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

  fun withTreatment () =
    let
      val withTreatmentModel = WithTreatmentModel.run()
    in
      ( WithTreatmentModel.printOutput withTreatmentModel; true )
    end

end
