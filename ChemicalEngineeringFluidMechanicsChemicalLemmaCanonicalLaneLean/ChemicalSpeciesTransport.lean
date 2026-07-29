import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidOperators

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

abbrev SpeciesConcentration := ScalarField
abbrev DiffusionCoefficient := ℝ

structure ChemicalSpecies where
  name : String
  concentration : SpeciesConcentration
  diffusionCoeff : DiffusionCoefficient
  molecularWeight : ℝ

def zeroConcentration : SpeciesConcentration := fun _ _ => 0

structure TransportReactionOperators where
  advDiffReaction : VectorField → SpeciesConcentration → SpeciesConcentration
  reactionSource : SpeciesConcentration → ScalarField
  reactionSink : SpeciesConcentration → ScalarField
  reactionRateConstant : ℝ

def primitiveTransportReactionOperators : TransportReactionOperators := {
  advDiffReaction := fun _ _ => zeroConcentration
  reactionSource := fun _ => zeroScalarField
  reactionSink := fun _ => zeroScalarField
  reactionRateConstant := 1
}

structure ReactiveFlow where
  flow : FluidFlow
  species : List ChemicalSpecies
  operators : TransportReactionOperators

def primitiveSpecies : List ChemicalSpecies := [
  { name := "A", concentration := zeroConcentration, diffusionCoeff := 1, molecularWeight := 18.0 }
]

def primitiveReactiveFlow : ReactiveFlow := {
  flow := primitiveFlow
  species := primitiveSpecies
  operators := primitiveTransportReactionOperators
}

def SpeciesMassBalance (R : ReactiveFlow) : Prop :=
  ∀ s ∈ R.species, R.operators.advDiffReaction R.flow.velocity s.concentration = zeroConcentration

def ReactionRateClosed (R : ReactiveFlow) : Prop :=
  R.operators.reactionSource zeroConcentration = zeroScalarField ∧
  R.operators.reactionSink zeroConcentration = zeroScalarField

def TransportReactionClosed (R : ReactiveFlow) : Prop :=
  SpeciesMassBalance R ∧ ReactionRateClosed R

theorem primitive_species_mass_balance_checked : SpeciesMassBalance primitiveReactiveFlow := by
  intro s hs
  simp [primitiveReactiveFlow, primitiveTransportReactionOperators, zeroConcentration]
  rfl

theorem primitive_reaction_rate_closed_checked : ReactionRateClosed primitiveReactiveFlow := by
  exact And.intro rfl rfl

theorem primitive_transport_reaction_closed_checked : TransportReactionClosed primitiveReactiveFlow := by
  exact And.intro primitive_species_mass_balance_checked primitive_reaction_rate_closed_checked

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse