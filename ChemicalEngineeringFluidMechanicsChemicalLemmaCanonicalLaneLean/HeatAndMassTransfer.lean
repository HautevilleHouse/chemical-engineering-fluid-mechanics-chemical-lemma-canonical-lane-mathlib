import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidOperators

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure HeatTransferOperators where
  thermalDiffusivity : ℝ
  heatSource : ScalarField
  temperature : ScalarField
  advection : VectorField → ScalarField → ScalarField
  diffusion : ScalarField → ScalarField

def primitiveHeatTransferOperators : HeatTransferOperators := {
  thermalDiffusivity := 1
  heatSource := zeroScalarField
  temperature := zeroScalarField
  advection := fun _ _ => zeroScalarField
  diffusion := fun _ => zeroScalarField
}

structure MassTransferOperators where
  massDiffusivity : ℝ
  massSource : ScalarField
  concentration : ScalarField
  advection : VectorField → ScalarField → ScalarField
  diffusion : ScalarField → ScalarField

def primitiveMassTransferOperators : MassTransferOperators := {
  massDiffusivity := 1
  massSource := zeroScalarField
  concentration := zeroScalarField
  advection := fun _ _ => zeroScalarField
  diffusion := fun _ => zeroScalarField
}

structure HeatAndMassSystem where
  flow : FluidFlow
  heatOperators : HeatTransferOperators
  massOperators : MassTransferOperators

def primitiveHeatAndMassSystem : HeatAndMassSystem := {
  flow := primitiveFlow
  heatOperators := primitiveHeatTransferOperators
  massOperators := primitiveMassTransferOperators
}

def HeatEquationClosed (H : HeatAndMassSystem) : Prop :=
  H.heatOperators.advection H.flow.velocity H.heatOperators.temperature = zeroScalarField ∧
  H.heatOperators.diffusion H.heatOperators.temperature = zeroScalarField ∧
  H.heatOperators.heatSource = zeroScalarField

def MassEquationClosed (M : HeatAndMassSystem) : Prop :=
  M.massOperators.advection M.flow.velocity M.massOperators.concentration = zeroScalarField ∧
  M.massOperators.diffusion M.massOperators.concentration = zeroScalarField ∧
  M.massOperators.massSource = zeroScalarField

def HeatMassClosed (H : HeatAndMassSystem) : Prop :=
  HeatEquationClosed H ∧ MassEquationClosed H

theorem primitive_heat_equation_closed_checked : HeatEquationClosed primitiveHeatAndMassSystem := by
  exact And.intro rfl (And.intro rfl rfl)

theorem primitive_mass_equation_closed_checked : MassEquationClosed primitiveHeatAndMassSystem := by
  exact And.intro rfl (And.intro rfl rfl)

theorem primitive_heat_mass_closed_checked : HeatMassClosed primitiveHeatAndMassSystem := by
  exact And.intro primitive_heat_equation_closed_checked primitive_mass_equation_closed_checked

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse