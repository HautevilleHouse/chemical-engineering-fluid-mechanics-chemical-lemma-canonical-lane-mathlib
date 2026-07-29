import ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

def ConstrainedChemicalEngineeringClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_chemical_engineering_endgame (A : AdmissibleClass) :
    ConstrainedChemicalEngineeringClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse