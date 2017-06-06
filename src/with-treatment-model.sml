structure WithTreatmentModel =
struct

  local
    type model = { susceptibles: real, infected: real, zombies: real, removed: real }
    val basePopulation = 500.0
    val alpha = 0.005
    val beta = 0.0095
    val rho = 5.0
    val zeta = 5.0
    val cure = 0.3
    val delta = 0.0001
    val stoppingTime = 10.0
    val timeStep = 0.01

    fun calculate (withTreatmentModel, counter: int) =
      if counter = 0 then []
      else if (#susceptibles withTreatmentModel) < 0.0 orelse (#susceptibles withTreatmentModel) > basePopulation
        then withTreatmentModel :: calculate(withTreatmentModel, counter - 1)
      else if (#infected withTreatmentModel) < 0.0 orelse (#infected withTreatmentModel) > basePopulation
        then withTreatmentModel :: calculate(withTreatmentModel, counter - 1)
      else if (#zombies withTreatmentModel) < 0.0 orelse (#zombies withTreatmentModel) > basePopulation
        then withTreatmentModel :: calculate(withTreatmentModel, counter - 1)
      else if (#removed withTreatmentModel) < 0.0 orelse (#removed withTreatmentModel) > basePopulation
        then withTreatmentModel :: calculate(withTreatmentModel, counter - 1)
      else
        let
          val susceptibles = (#susceptibles withTreatmentModel)
          val infected = (#infected withTreatmentModel)
          val zombies = (#zombies withTreatmentModel)
          val removed = (#removed withTreatmentModel)
          val deltaS = (delta * susceptibles)
          val rhoI = (rho * infected)
          val deltaI = (delta * infected)
          val betaSZ = (beta * susceptibles * zombies)
          val cureZ = (cure * zombies)
          val zetaR = (zeta * removed)
          val alphaSZ = (alpha * susceptibles * zombies)
          val nextModel = {
            susceptibles = (susceptibles + (timeStep * (~betaSZ + cureZ))),
            infected = (infected + (timeStep * (betaSZ - rhoI - deltaI))),
            zombies = (zombies + (timeStep * (rhoI + zetaR - alphaSZ - cureZ))),
            removed = (removed + (timeStep * (deltaS + deltaI + alphaSZ - zetaR)))
          }
        in
          nextModel :: calculate(nextModel, counter - 1)
        end

    fun printModel (withTreatmentModel: model list, index) =
      if null withTreatmentModel then print ""
      else if index mod 50 <> 0 then printModel((tl withTreatmentModel), (index + 1))
      else
        (
          print (
            "{ timestamp: " ^ (Real.toString(Real.fromInt(index) * timeStep)) ^
            ", susceptible: " ^ (Real.toString((#susceptibles (hd withTreatmentModel)))) ^
            ", infected: " ^ (Real.toString((#infected (hd withTreatmentModel)))) ^
            ", zombie: " ^ (Real.toString((#zombies (hd withTreatmentModel)))) ^
            ", removed: " ^ (Real.toString((#removed (hd withTreatmentModel)))) ^
            " }\n"
          );
          printModel((tl withTreatmentModel), (index + 1))
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

    fun printOutput (withTreatmentModel: model list) =
      (
        print (
          "Running with treatment model using values: \n" ^
          "{ alpha: " ^ (Real.toString alpha) ^
          ", beta: " ^ (Real.toString beta) ^
          ", rho: " ^ (Real.toString rho) ^
          ", zeta: " ^ (Real.toString zeta) ^
          ", delta: " ^ (Real.toString delta) ^
          ", cure-rate: " ^ (Real.toString cure) ^
          ", timeStep: " ^ (Real.toString timeStep) ^
          ", stoppingTime: " ^ (Real.toString stoppingTime) ^
          " }\n\n"
        );
        printModel(withTreatmentModel, 0)
      )
  end
end
