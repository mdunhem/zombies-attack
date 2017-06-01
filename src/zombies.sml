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
        print "Running latent infection: \n";
        map (fn v => print (
          "{ susceptible: " ^ (Real.toString((#susceptibles v))) ^
          ", infected: " ^ (Real.toString((#infected v))) ^
          ", zombie: " ^ (Real.toString((#zombies v))) ^
          ", removed: " ^ (Real.toString((#removed v))) ^
          " }\n")) basicModel;
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
