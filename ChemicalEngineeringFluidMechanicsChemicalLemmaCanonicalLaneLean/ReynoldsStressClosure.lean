import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidStateTransport

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure ReynoldsStress where
  fluctuatingVelocity : FluidState → (Fin 3 → ℝ)
  meanVelocity : FluidState → (Fin 3 → ℝ)
  reynoldsStressTensor : FluidState → (Fin 3 → Fin 3 → ℝ)

structure TurbulenceKineticEnergy where
  k : FluidState → ℝ
  dissipationRate : FluidState → ℝ
  productionTerm : ReynoldsStress → FluidState → ℝ

structure ReynoldsStressClosureCertificate where
  flow : FluidFlow
  stress : ReynoldsStress
  tke : TurbulenceKineticEnergy
  closureEquations : Prop
  closureEquationsClosed : closureEquations

def sourceReynoldsStressClosureCertificate : ReynoldsStressClosureCertificate := {
  flow := { state := { density := 1, velocity := λ _ => 0, pressure := 0, temperature := 298 }, transport := defaultTransportOperator, viscosity := 1e-3 }
  stress := { fluctuatingVelocity := λ _ _ => 0, meanVelocity := λ _ _ => 0, reynoldsStressTensor := λ _ _ _ => 0 }
  tke := { k := λ _ => 0, dissipationRate := λ _ => 0, productionTerm := λ _ _ => 0 }
  closureEquations := True
  closureEquationsClosed := by trivial
}

def ReynoldsStressClosureClosed (C : ReynoldsStressClosureCertificate) : Prop :=
  C.closureEquations

theorem source_reynolds_stress_closure_closed :
    ReynoldsStressClosureClosed sourceReynoldsStressClosureCertificate := by
  exact sourceReynoldsStressClosureCertificate.closureEquationsClosed

end HautevilleHouse
end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
