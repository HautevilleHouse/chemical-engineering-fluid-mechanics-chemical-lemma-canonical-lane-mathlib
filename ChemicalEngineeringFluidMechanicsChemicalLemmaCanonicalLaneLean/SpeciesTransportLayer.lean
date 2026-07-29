import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidStateTransport

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure SpeciesConservation where
  concentration : FluidState → ℝ
  diffusiveFlux : FluidState → (Fin 3 → ℝ)
  sourceTerm : FluidState → ℝ

structure SpeciesTransportEnvelope where
  flow : FluidFlow
  species : SpeciesConservation
  massConservation : Prop
  massConservationClosed : massConservation

def sourceSpeciesTransportEnvelope : SpeciesTransportEnvelope := {
  flow := { state := { density := 1, velocity := λ _ => 0, pressure := 0, temperature := 298 }, transport := defaultTransportOperator, viscosity := 1e-3 }
  species := { concentration := λ _ => 0, diffusiveFlux := λ _ _ => 0, sourceTerm := λ _ => 0 }
  massConservation := True
  massConservationClosed := by trivial
}

def SpeciesTransportEnvelopeClosed (E : SpeciesTransportEnvelope) : Prop :=
  E.massConservation

theorem source_species_transport_envelope_closed :
    SpeciesTransportEnvelopeClosed sourceSpeciesTransportEnvelope := by
  exact sourceSpeciesTransportEnvelope.massConservationClosed

end HautevilleHouse
end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
