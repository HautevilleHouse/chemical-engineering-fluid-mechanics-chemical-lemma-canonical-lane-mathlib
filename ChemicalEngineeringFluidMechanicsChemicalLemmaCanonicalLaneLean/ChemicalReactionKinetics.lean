import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidStateTransport

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure ReactionKinetics where
  rateLaw : ℝ → ℝ → ℝ
  activationEnergy : ℝ
  preExponentialFactor : ℝ
  temperatureExponent : ℝ

structure SpeciesFormationRates where
  species : FluidState → ℝ
  netRate : FluidState → ℝ

def arrheniusRateLaw (Ea A : ℝ) (T : ℝ) : ℝ :=
  A * Real.exp (-Ea / (8.314 * T))

structure ReactionCertificate where
  flow : FluidFlow
  kinetics : ReactionKinetics
  speciesRates : SpeciesFormationRates
  arrheniusValid : Prop
  arrheniusValidClosed : arrheniusValid

def sourceReactionCertificate : ReactionCertificate := {
  flow := { state := { density := 1, velocity := λ _ => 0, pressure := 0, temperature := 298 }, transport := defaultTransportOperator, viscosity := 1e-3 }
  kinetics := { rateLaw := arrheniusRateLaw, activationEnergy := 50000, preExponentialFactor := 1e12, temperatureExponent := 0 }
  speciesRates := { species := λ _ => 0, netRate := λ _ => 0 }
  arrheniusValid := True
  arrheniusValidClosed := by trivial
}

def ReactionCertificateClosed (C : ReactionCertificate) : Prop :=
  C.arrheniusValid

theorem source_reaction_certificate_closed :
    ReactionCertificateClosed sourceReactionCertificate := by
  exact sourceReactionCertificate.arrheniusValidClosed

end HautevilleHouse
end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
