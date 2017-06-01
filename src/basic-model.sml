structure BasicModel =
struct

  type model = { susceptibles: real, zombies: real, removed: real }
  local
    val basePopulation = 500.0
    val alpha = 0.005
    val beta = 0.0095
    val zeta = 0.07
    val delta = 0.09
    val stoppingTime = 5.0
    val timeStep = 0.01

    fun calculate (basicModel, counter: int) =
      if counter = 0 then []
      else if (#susceptibles basicModel) < 0.0 orelse (#susceptibles basicModel) > basePopulation then []
      else if (#zombies basicModel) < 0.0 orelse (#zombies basicModel) > basePopulation then []
      else if (#removed basicModel) < 0.0 orelse (#removed basicModel) > basePopulation then []
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
          val counter = counter - 1
        in
          nextModel :: calculate(nextModel, counter)
        end

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
    fun run () =
      let
        (*Initial set up of solution vectors and an initial condition*)
        val counter = (Real.trunc (stoppingTime / timeStep))
        val startingModel = { susceptibles = basePopulation, zombies = 0.0, removed = 0.0 }
      in
        startingModel :: calculate(startingModel, counter)
      end

    fun printOutput (basicModel: model list) =
      (
        print (
          "Running basic model with values: \n" ^
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
