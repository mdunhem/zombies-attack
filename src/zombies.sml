structure Zombie =
struct

  fun basic() =
    let
      val sampleOutput = "Running basic model"
    in
      (print sampleOutput; true)
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
