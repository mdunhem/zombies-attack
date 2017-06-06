(**
 * SML implementation of Munz's basic model with treatment.
 *
 * It uses the same algorithm that the MATLAB code from the paper uses although
 * some of the parameters have been changed. Some of the parameters listed in
 * the MATLAB code do not produce the same result that is listed in the paper
 * but with the updated parameters it does.
 *)
structure WithTreatment =
struct

  local
    type model = { susceptibles: real, infected: real, zombies: real, removed: real }

    (*Parameters used by the algorithm to solve the ODE's*)
    val basePopulation = 500.0
    val alpha = 0.005 (*Zombie destruction rate*)
    val beta = 0.0095 (*New infected rate*)
    val rho = 5.0 (*Infected to Zombie rate*)
    val zeta = 5.0 (*Zombie resurrection rate*)
    val treatment = 0.3 (*Zombie treatment rate*)
    val delta = 0.0001 (*Natural death rate*)
    val stoppingTime = 10.0
    val timeStep = 0.01

    (**
     * Main function to calculate the basic model with treatment. It calls
     * itself recursively based on stoppingTime divided by timeStep. This is
     * based on the same algorithm that Munz utilized in his MATLAB code. It is
     * purposely verbose to show how the algorithm works and how each value is
     * calculated.
     *
     * Each iteration creates a record consisting of the current values of each
     * type of population at the specific time-slice. It then appends it to the
     * final list that is returned once all iterations have completed.
     *)
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
          val treatmentZ = (treatment * zombies)
          val zetaR = (zeta * removed)
          val alphaSZ = (alpha * susceptibles * zombies)
          val nextModel = {
            susceptibles = (susceptibles + (timeStep * (~betaSZ + treatmentZ))),
            infected = (infected + (timeStep * (betaSZ - rhoI - deltaI))),
            zombies = (zombies + (timeStep * (rhoI + zetaR - alphaSZ - treatmentZ))),
            removed = (removed + (timeStep * (deltaS + deltaI + alphaSZ - zetaR)))
          }
        in
          nextModel :: calculate(nextModel, counter - 1)
        end

    (**
     * Recursively runs through each record in the model list and prints it out.
     * It limits the printed values so as to not flood the command prompt.
     *)
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
    (**
     * Function called to run the calculation and returns the list of records
     * consisting of the values from each class of population at each time-slice.
     *)
    fun run () =
      let
        (*Initial set up of counter and an initial model*)
        val counter = (Real.trunc (stoppingTime / timeStep))
        val startingModel = { susceptibles = basePopulation, infected = 0.0, zombies = 0.0, removed = 0.0 }
      in
        startingModel :: calculate(startingModel, counter)
      end

    (**
     * Function called to print out all algorithm values as well as the model
     * list.
     *)
    fun printOutput (withTreatmentModel: model list) =
      (
        print (
          "Running with treatment model using values: \n" ^
          "{ alpha: " ^ (Real.toString alpha) ^
          ", beta: " ^ (Real.toString beta) ^
          ", rho: " ^ (Real.toString rho) ^
          ", zeta: " ^ (Real.toString zeta) ^
          ", delta: " ^ (Real.toString delta) ^
          ", treatment-rate: " ^ (Real.toString treatment) ^
          ", timeStep: " ^ (Real.toString timeStep) ^
          ", stoppingTime: " ^ (Real.toString stoppingTime) ^
          " }\n\n"
        );
        printModel(withTreatmentModel, 0)
      )
  end
end
