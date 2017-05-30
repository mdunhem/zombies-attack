structure Zombies =
struct

  fun basic() =
    let
      val zombieDestructionRate = 0.005
      val newZombieRate = 0.0095
      val zombieResurectionRate = 0.0001
      val backgroundDeathRate = 0.0001
      val stoppingTime = 20.0
      val timeStep = 0.5
      val basicModel = BasicModel.run (
        zombieDestructionRate,
        newZombieRate,
        zombieResurectionRate,
        backgroundDeathRate,
        stoppingTime,
        timeStep
      )
    in
      (
        print "Running basic model: \n";
        map (fn v => print (
          "{ susceptible: " ^ (Real.toString((#susceptibles v))) ^
          ", zombie: " ^ (Real.toString((#zombies v))) ^
          ", removed: " ^ (Real.toString((#removed v))) ^
          " }\n")) basicModel;
        true
      )
    end

  fun latentInfection() =
    let
      val sampleOutput = "Running basic model with latent infection"
    in
      (print sampleOutput; true)
    end

  fun quarantine() =
    let
      val sampleOutput = "Running basic model with quarantine"
    in
      (print sampleOutput; true)
    end

end


(* Susceptible' = birthrate - (transmissionParameter * SusceptibleCount * ZombieCount) - (naturaldeathParameter SusceptibleCount) *)
(* Zombie' = (transmissionParameter * SusceptibleCount * ZombieCount) + (becomeAZombieParameter * RemovedCount) - (killedZombieParameter * SusceptibleCount * ZombieCount) *)
(* Removed' = (naturaldeathParameter SusceptibleCount) + (killedZombieParameter * SusceptibleCount * ZombieCount) - (becomeAZombieParameter * RemovedCount) *)

(**
 *  Basic Model
 *)
(*fun basic(zombieDestructionRate: int, newZombieRate: int, zombieResurectionRate: int, backgroundDeathRate: int, stoppingTime: int, timeStep: int) =
    let
        val population = 500
        val n = stoppingTime div timeStep
    in
        population + n
    end*)
