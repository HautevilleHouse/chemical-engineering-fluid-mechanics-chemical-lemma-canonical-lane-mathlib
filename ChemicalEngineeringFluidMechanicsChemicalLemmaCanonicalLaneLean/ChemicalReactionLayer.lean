import ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.ReynoldsStressLayer

/-!
# Chemical Reaction Layer

This module defines species transport and reaction kinetics for chemical engineering fluid mechanics.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure Species where
  name : String
  concentration : ScalarField
  diffusivity : ℝ

def reactionRate (rateConstant : ℝ) (concentrations : List ScalarField) : ScalarField :=
  fun t x => rateConstant * (concentrations.map (fun c => c t x)).prod

def AdvectionDiffusionReaction (F : FluidFlow) (c : ScalarField) (D : ℝ) (R : ScalarField) : Prop :=
  ChemicalSpeciesTransport F c D ∧ 
  F.operators.timeDerivative c = F.operators.timeDerivative c + R

def SimpleReactionKinetics (k : ℝ) (A : ScalarField) (B : ScalarField) (C : ScalarField) : Prop :=
  reactionRate k [A, B] = C

structure ReactionNetwork where
  species : List Species
  reactions : List (Species × Species × Species × ℝ)

def MassActionKinetics (network : ReactionNetwork) : Prop :=
  (∀ (a, b, c, k) ∈ network.reactions, SimpleReactionKinetics k a.concentration b.concentration c.concentration)

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse