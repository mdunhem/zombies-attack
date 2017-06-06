(**
 * SML implementation of Munz's basic model.
 *
 * It uses the same algorithm that the MATLAB code from the paper uses although
 * some of the parameters have been changed. Some of the parameters listed in
 * the MATLAB code do not produce the same result that is listed in the paper
 * but with the updated parameters it does.
 *)
structure BasicModel =
struct

  local
    type model = { susceptibles: real, zombies: real, removed: real }

    (*Parameters used by the algorithm to solve the ODE's*)
    val basePopulation = 500.0
    val alpha = 0.005 (*Zombie destruction rate*)
    val beta = 0.0095 (*New Zombie rate*)
    val zeta = 5.0 (*Zombie resurrection rate*)
    val delta = 0.0001 (*Natural death rate*)
    val stoppingTime = 5.0
    val timeStep = 0.01

    (**
     * Main function to calculate the basic model. It calls itself recursively
     * based on stoppingTime divided by timeStep. This is based on the same
     * algorithm that Munz utilized in his MATLAB code. It is purposely
     * verbose to show how the algorithm works and how each value is calculated.
     *
     * Each iteration creates a record consisting of the current values of each
     * type of population at the specific time-slice. It then appends it to the
     * final list that is returned once all iterations have completed.
     *)
    fun calculate (basicModel, counter: int) =
      if counter = 0 then []
      else if (#susceptibles basicModel) < 0.0 orelse (#susceptibles basicModel) > basePopulation
        then basicModel :: calculate(basicModel, counter - 1)
      else if (#zombies basicModel) < 0.0 orelse (#zombies basicModel) > basePopulation
        then basicModel :: calculate(basicModel, counter - 1)
      else if (#removed basicModel) < 0.0 orelse (#removed basicModel) > basePopulation
        then basicModel :: calculate(basicModel, counter - 1)
      else
        let
          val susceptibles = (#susceptibles basicModel)
          val zombies = (#zombies basicModel)
          val removed = (#removed basicModel)
          val deltaS = (delta * susceptibles)
          val betaSZ = (beta * susceptibles * zombies)
          val zetaR = (zeta * removed)
          val alphaSZ = (alpha * susceptibles * zombies)
          val nextModel = {
            susceptibles = (susceptibles + (timeStep * (~betaSZ))),
            zombies = (zombies + (timeStep * (betaSZ + zetaR - alphaSZ))),
            removed = (removed + (timeStep * (deltaS + alphaSZ - zetaR)))
          }
        in
          nextModel :: calculate(nextModel, counter - 1)
        end

    (**
     * Recursively runs through each record in the model list and prints it out.
     * It limits the printed values so as to not flood the command prompt.
     *)
    fun printModel (basicModel: model list, index) =
      if null basicModel then print ""
      else if index mod 50 <> 0 then printModel((tl basicModel), (index + 1))
      else
        (
          print (
            "{ timestamp: " ^ (Real.toString(Real.fromInt(index) * timeStep)) ^
            ", susceptible: " ^ (Real.toString((#susceptibles (hd basicModel)))) ^
            ", zombie: " ^ (Real.toString((#zombies (hd basicModel)))) ^
            ", removed: " ^ (Real.toString((#removed (hd basicModel)))) ^
            " }\n"
          );
          printModel((tl basicModel), (index + 1))
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
        val startingModel = { susceptibles = basePopulation, zombies = 0.0, removed = 0.0 }
      in
        startingModel :: calculate(startingModel, counter)
      end

    (**
     * Function called to print out all algorithm values as well as the model
     * list.
     *)
    fun printOutput (basicModel: model list) =
      (
        print (
          "Running basic model using values: \n" ^
          "{ alpha: " ^ (Real.toString alpha) ^
          ", beta: " ^ (Real.toString beta) ^
          ", zeta: " ^ (Real.toString zeta) ^
          ", delta: " ^ (Real.toString delta) ^
          ", timeStep: " ^ (Real.toString timeStep) ^
          ", stoppingTime: " ^ (Real.toString stoppingTime) ^
          " }\n\n"
        );
        printModel(basicModel, 0)
      )
  end

end
