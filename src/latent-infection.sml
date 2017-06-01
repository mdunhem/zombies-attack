structure LatentInfection =
struct

  local
    type model = { susceptibles: real, infected: real, zombies: real, removed: real }
    val basePopulation = 500.0
    val alpha = 0.005
    val beta = 0.0028
    val rho = 5.0
    val zeta = 5.0
    val delta = 0.09
    val stoppingTime = 10.0
    val timeStep = 0.01

    fun calculate (latentInfectionModel, counter: int) =
      if counter = 0 then []
      else if (#susceptibles latentInfectionModel) < 0.0 orelse (#susceptibles latentInfectionModel) > basePopulation
        then latentInfectionModel :: calculate(latentInfectionModel, counter - 1)
      else if (#infected latentInfectionModel) < 0.0 orelse (#infected latentInfectionModel) > basePopulation
        then latentInfectionModel :: calculate(latentInfectionModel, counter - 1)
      else if (#zombies latentInfectionModel) < 0.0 orelse (#zombies latentInfectionModel) > basePopulation
        then latentInfectionModel :: calculate(latentInfectionModel, counter - 1)
      else if (#removed latentInfectionModel) < 0.0 orelse (#removed latentInfectionModel) > basePopulation
        then latentInfectionModel :: calculate(latentInfectionModel, counter - 1)
      else
        let
          val susceptibles = (#susceptibles latentInfectionModel)
          val infected = (#infected latentInfectionModel)
          val zombies = (#zombies latentInfectionModel)
          val removed = (#removed latentInfectionModel)
          val deltaS = (delta * susceptibles)
          val rhoI = (rho * infected)
          val deltaI = (delta * infected)
          val betaSZ = (beta * susceptibles * zombies)
          val zetaR = (zeta * removed)
          val alphaSZ = (alpha * susceptibles * zombies)
          val nextModel = {
            susceptibles = (susceptibles + (timeStep * (~betaSZ))),
            infected = (infected + (timeStep * (betaSZ - rhoI - deltaI))),
            zombies = (zombies + (timeStep * (rhoI + zetaR - alphaSZ))),
            removed = (removed + (timeStep * (deltaS + deltaI + alphaSZ - zetaR)))
          }
        in
          nextModel :: calculate(nextModel, counter - 1)
        end

    fun printModel (latentInfectionModel: model list, index) =
      if null latentInfectionModel then print ""
      else if index mod 50 <> 0 then printModel((tl latentInfectionModel), (index + 1))
      else
        (
          print (
            "{ timestamp: " ^ (Real.toString(Real.fromInt(index) * timeStep)) ^
            ", susceptible: " ^ (Real.toString((#susceptibles (hd latentInfectionModel)))) ^
            ", infected: " ^ (Real.toString((#infected (hd latentInfectionModel)))) ^
            ", zombie: " ^ (Real.toString((#zombies (hd latentInfectionModel)))) ^
            ", removed: " ^ (Real.toString((#removed (hd latentInfectionModel)))) ^
            " }\n"
          );
          printModel((tl latentInfectionModel), (index + 1))
        )
  in
    fun run () =
      let
        (*Initial set up of solution vectors and an initial condition*)
        val counter = (Real.trunc (stoppingTime / timeStep))
        val startingModel = { susceptibles = basePopulation, infected = 0.0, zombies = 0.0, removed = 0.0 }
      in
        startingModel :: calculate(startingModel, counter)
      end

    fun printOutput (latentInfectionModel: model list) =
      (
        print (
          "Running latent infection model with values: \n" ^
          "{ alpha: " ^ (Real.toString alpha) ^
          ", beta: " ^ (Real.toString beta) ^
          ", rho: " ^ (Real.toString rho) ^
          ", zeta: " ^ (Real.toString zeta) ^
          ", delta: " ^ (Real.toString delta) ^
          ", timeStep: " ^ (Real.toString timeStep) ^
          ", stoppingTime: " ^ (Real.toString stoppingTime) ^
          " }\n\n"
        );
        printModel(latentInfectionModel, 0)
      )
  end
end

(*
alpha = 0.005;
  beta = 0.0095;
  rho = 2.0;
  zeta = 0.07;
  delta = 0.09;
  t = 10.0;
  dt = 0.01;
*)
