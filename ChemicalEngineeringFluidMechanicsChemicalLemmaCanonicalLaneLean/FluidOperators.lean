import ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.AdmissibleClass

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure FluidOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : FluidOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure FluidFlow where
  velocity : VectorField
  pressure : ScalarField
  viscosity : ℝ
  density : ℝ
  operators : FluidOperators

def primitiveFlow : FluidFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  viscosity := 1
  density := 1
  operators := primitiveOperators
}

def Incompressible (F : FluidFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def MomentumBalance (F : FluidFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def PressureProjected (F : FluidFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def FluidEquationClosed (F : FluidFlow) : Prop :=
  Incompressible F ∧ MomentumBalance F ∧ PressureProjected F

theorem primitive_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveOperators.pressureProjection (primitiveOperators.pressureProjection u) =
      primitiveOperators.pressureProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_momentum_balance_checked :
    MomentumBalance primitiveFlow := by
  rfl

theorem primitive_flow_pressure_projected_checked :
    PressureProjected primitiveFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    FluidEquationClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_momentum_balance_checked primitive_flow_pressure_projected_checked)

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse