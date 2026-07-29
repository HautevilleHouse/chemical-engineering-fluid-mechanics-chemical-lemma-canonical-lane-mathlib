import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

abbrev SpatialPoint := Fin 3 → ℝ
abbrev Time := ℝ

structure FluidState where
  density : ℝ
  velocity : Fin 3 → ℝ
  pressure : ℝ
  temperature : ℝ

structure TransportOperator where
  divergence : (Fin 3 → ℝ) → ℝ
  gradient : ℝ → Fin 3 → ℝ
  laplacian : ℝ → ℝ
  advection : (Fin 3 → ℝ) → (Fin 3 → ℝ) → (Fin 3 → ℝ)

def defaultTransportOperator : TransportOperator := {
  divergence := λ _ => 0
  gradient := λ _ _ => 0
  laplacian := λ _ => 0
  advection := λ u v _ => 0
}

structure FluidFlow where
  state : FluidState
  transport : TransportOperator
  viscosity : ℝ

end HautevilleHouse
end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
