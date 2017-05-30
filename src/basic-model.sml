structure BasicModel =
struct

  val basePopulation = 500.0

  fun calculate (basicModel, newZombieRate: real, zombieDestructionRate: real, zombieResurectionRate: real, backgroundDeathRate: real, timeStep: real, counter: int) =
    if counter = 0 then []
    else if (#susceptibles basicModel) < 0.0 orelse (#susceptibles basicModel) > basePopulation then []
    else if (#zombies basicModel) < 0.0 orelse (#zombies basicModel) > basePopulation then []
    else if (#removed basicModel) < 0.0 orelse (#removed basicModel) > basePopulation then []
    else
      let
        val susceptibles = (#susceptibles basicModel)
        val zombies = (#zombies basicModel)
        val removed = (#removed basicModel)
        val nextSusceptible = susceptibles + (timeStep * (~newZombieRate * susceptibles * zombies))
        val nextZombie = zombies + (timeStep * ((newZombieRate * susceptibles * zombies) - (zombieDestructionRate * susceptibles * zombies) + (zombieResurectionRate * removed)))
        val nextRemoved = removed + (timeStep * ((zombieDestructionRate * susceptibles * zombies) + (backgroundDeathRate * susceptibles) - (zombieResurectionRate * removed)))
        val nextCounter = counter - 1
        val nextModel = { susceptibles = nextSusceptible, zombies = nextZombie, removed = nextRemoved }
      in
        nextModel :: calculate(nextModel, newZombieRate, zombieDestructionRate, zombieResurectionRate, backgroundDeathRate, timeStep, nextCounter)
      end

  fun run (zombieDestructionRate: real, newZombieRate: real, zombieResurectionRate: real, backgroundDeathRate: real, stoppingTime: real, timeStep: real) =
    let
      (*Initial set up of solution vectors and an initial condition*)
      val counter = (Real.trunc (stoppingTime / timeStep))
      val startingModel = { susceptibles = basePopulation, zombies = 0.0, removed = 0.0 }

    in
      startingModel :: calculate(startingModel, newZombieRate, zombieDestructionRate, zombieResurectionRate, backgroundDeathRate, timeStep, counter)
    end

end


(*print ("counter: " ^ (Int.toString nextCounter) ^ "\n");
print ("{ susceptible: " ^ (Real.toString((#susceptibles nextModel))) ^ ", zombie: " ^ (Real.toString((#zombies nextModel))) ^ ", removed: " ^ (Real.toString((#removed nextModel))) ^ " }\n");*)

(*val t = makeListOfZeros(n + 1) (* zeros(1,n+1) *)
val susceptibles = N :: 2 :: 3 :: tl (makeListOfZeros(n + 1)) (* zeros(1,n+1) *)
val zombies = 0 :: 2 :: makeListOfZeros(n + 1)  (*makeListOfZeros(n + 1) zeros(1,n+1) *)
val removed = [0]  (*makeListOfZeros(n + 1)  zeros(1,n+1) *)*)

(*val s(1) = N;
val z(1) = 0;
val r(1) = 0;
val t = 0:dt:T;*)
(*val sampleOutput =
  "Running basic model\n" ^
  "zombieDestructionRate: " ^ Int.toString zombieDestructionRate ^ "\n" ^
  "newZombieRate: " ^ Int.toString newZombieRate ^ "\n" ^
  "zombieResurectionRate: " ^ Int.toString zombieResurectionRate ^ "\n" ^
  "backgroundDeathRate: " ^ Int.toString backgroundDeathRate ^ "\n" ^
  "stoppingTime: " ^ Int.toString stoppingTime ^ "\n" ^
  "timeStep: " ^ Int.toString timeStep ^ "\n" ^
  "n: " ^ Int.toString n ^ "\n"*)
(*val calculation = calculate(basicModel, newZombieRate, zombieDestructionRate, zombieResurectionRate, backgroundDeathRate, timeStep, counter)*)
