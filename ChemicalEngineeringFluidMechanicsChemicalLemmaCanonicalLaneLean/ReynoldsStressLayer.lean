import ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidDynamicsOperators

/-!
# Reynolds Stress Layer

This module defines the Reynolds stress tensor and turbulent kinetic energy closure models.
-/

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure ReynoldsStress where
  velocityFlux : VectorField → VectorField → VectorField
  reynoldsStressTensor : VectorField → VectorField → ScalarField

def simpleReynoldsStress : ReynoldsStress := {
  velocityFlux := fun u v => fun t x => (u t x).1 * (v t x).1
  reynoldsStressTensor := fun u v => fun t x => (u t x).1 * (v t x).1
}

def TurbulentKineticEnergy (k : ScalarField) (epsilon : ScalarField) : Prop :=
  ∀ t x, k t x ≥ 0 ∧ epsilon t x ≥ 0

def KOmegaClosure (k : ScalarField) (omega : ScalarField) : Prop :=
  TurbulentKineticEnergy k (fun t x => omega t x * k t x)

def ReynoldsStressClosure (F : FluidFlow) (k : ScalarField) (epsilon : ScalarField) : Prop :=
  Incompressible F ∧ TurbulentKineticEnergy k epsilon ∧ KOmegaClosure k epsilon

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse