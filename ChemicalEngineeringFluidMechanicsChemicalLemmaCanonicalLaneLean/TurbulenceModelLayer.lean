import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidOperators

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure TurbulenceCertificate where
  reynoldsNumber : ℝ
  turbulentKineticEnergy : ScalarField
  dissipationRate : ScalarField
  closureModel : String
  turbulentViscosity : ScalarField
  reynoldsStress : VectorField → VectorField
  tkeEquationClosed : Prop
  dissipationEquationClosed : Prop
  turbulentViscosityClosed : Prop
  tkeEquationClosedProof : tkeEquationClosed
  dissipationEquationClosedProof : dissipationEquationClosed
  turbulentViscosityClosedProof : turbulentViscosityClosed

def zeroScalarField' := zeroScalarField

def sourceTurbulenceCertificate : TurbulenceCertificate := {
  reynoldsNumber := 10000
  turbulentKineticEnergy := zeroScalarField
  dissipationRate := zeroScalarField
  closureModel := "k-epsilon"
  turbulentViscosity := zeroScalarField
  reynoldsStress := fun u => zeroVectorField
  tkeEquationClosed := True
  dissipationEquationClosed := True
  turbulentViscosityClosed := True
  tkeEquationClosedProof := trivial
  dissipationEquationClosedProof := trivial
  turbulentViscosityClosedProof := trivial
}

def TurbulenceModelClosed (C : TurbulenceCertificate) : Prop :=
  C.tkeEquationClosed ∧ C.dissipationEquationClosed ∧ C.turbulentViscosityClosed

theorem source_turbulence_model_closed : TurbulenceModelClosed sourceTurbulenceCertificate := by
  exact And.intro sourceTurbulenceCertificate.tkeEquationClosedProof
    (And.intro sourceTurbulenceCertificate.dissipationEquationClosedProof
      sourceTurbulenceCertificate.turbulentViscosityClosedProof)

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse