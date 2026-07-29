import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidOperators

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure PhaseFraction where
  phaseName : String
  volumeFraction : ScalarField
  density : ℝ
  viscosity : ℝ
  velocity : VectorField

def zeroPhaseFraction : PhaseFraction := {
  phaseName := ""
  volumeFraction := zeroScalarField
  density := 1
  viscosity := 1
  velocity := zeroVectorField
}

structure MultiphaseOperators where
  phaseAdvection : VectorField → ScalarField → ScalarField
  phaseCoupling : VectorField → VectorField → VectorField
  interfacialForces : ScalarField → VectorField

def primitiveMultiphaseOperators : MultiphaseOperators := {
  phaseAdvection := fun _ _ => zeroScalarField
  phaseCoupling := fun _ _ => zeroVectorField
  interfacialForces := fun _ => zeroVectorField
}

structure MultiphaseFlow where
  phases : List PhaseFraction
  operators : MultiphaseOperators

def primitiveMultiphaseFlow : MultiphaseFlow := {
  phases := [zeroPhaseFraction]
  operators := primitiveMultiphaseOperators
}

def PhaseConservation (M : MultiphaseFlow) : Prop :=
  ∀ p ∈ M.phases,
    p.volumeFraction = zeroScalarField ∨
    M.operators.phaseAdvection p.velocity p.volumeFraction = zeroScalarField

def MomentumCouplingClosed (M : MultiphaseFlow) : Prop :=
  ∀ p ∈ M.phases,
    M.operators.phaseCoupling p.velocity zeroVectorField = zeroVectorField

def InterfacialForceClosed (M : MultiphaseFlow) : Prop :=
  M.operators.interfacialForces zeroScalarField = zeroVectorField

def MultiphaseClosure (M : MultiphaseFlow) : Prop :=
  PhaseConservation M ∧ MomentumCouplingClosed M ∧ InterfacialForceClosed M

theorem primitive_phase_conservation_checked : PhaseConservation primitiveMultiphaseFlow := by
  intro p hp
  simp [primitiveMultiphaseFlow, zeroPhaseFraction, zeroScalarField]
  left; rfl

theorem primitive_momentum_coupling_closed_checked : MomentumCouplingClosed primitiveMultiphaseFlow := by
  intro p hp
  simp [primitiveMultiphaseFlow, primitiveMultiphaseOperators, zeroPhaseFraction]
  rfl

theorem primitive_interfacial_force_closed_checked : InterfacialForceClosed primitiveMultiphaseFlow := by
  simp [primitiveMultiphaseOperators]
  rfl

theorem primitive_multiphase_closed_checked : MultiphaseClosure primitiveMultiphaseFlow := by
  exact And.intro primitive_phase_conservation_checked
    (And.intro primitive_momentum_coupling_closed_checked primitive_interfacial_force_closed_checked)

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse