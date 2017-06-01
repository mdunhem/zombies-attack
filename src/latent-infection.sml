structure LatentInfection =
struct

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
    else if (#susceptibles latentInfectionModel) < 0.0 orelse (#susceptibles latentInfectionModel) > basePopulation then []
    else if (#infected latentInfectionModel) < 0.0 orelse (#infected latentInfectionModel) > basePopulation then []
    else if (#zombies latentInfectionModel) < 0.0 orelse (#zombies latentInfectionModel) > basePopulation then []
    else if (#removed latentInfectionModel) < 0.0 orelse (#removed latentInfectionModel) > basePopulation then []
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
        val counter = counter - 1
      in
        nextModel :: calculate(nextModel, counter)
      end

  fun run () =
    let
      (*Initial set up of solution vectors and an initial condition*)
      val counter = (Real.trunc (stoppingTime / timeStep))
      val startingModel = { susceptibles = basePopulation, infected = 0.0, zombies = 0.0, removed = 0.0 }
    in
      startingModel :: calculate(startingModel, counter)
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
