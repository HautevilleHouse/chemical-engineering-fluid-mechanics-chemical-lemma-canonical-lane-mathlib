import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidOperators

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure ViscosityModel where
  modelName : String
  zeroShearViscosity : ℝ
  infiniteShearViscosity : ℝ
  consistencyIndex : ℝ
  flowBehaviorIndex : ℝ
  yieldStress : ℝ

def powerLawViscosity : ViscosityModel := {
  modelName := "Power Law"
  zeroShearViscosity := 0
  infiniteShearViscosity := 0
  consistencyIndex := 1.0
  flowBehaviorIndex := 0.8
  yieldStress := 0
}

def binghamPlasticViscosity : ViscosityModel := {
  modelName := "Bingham Plastic"
  zeroShearViscosity := 0
  infiniteShearViscosity := 0
  consistencyIndex := 1.0
  flowBehaviorIndex := 1.0
  yieldStress := 5.0
}

structure NonNewtonianFlow where
  flow : FluidFlow
  viscosityModel : ViscosityModel
  apparentViscosity : ScalarField
  shearRate : ScalarField

def apparentViscosityFromModel (model : ViscosityModel) (shearRate : ℝ) : ℝ :=
  if model.modelName = "Power Law" then
    model.consistencyIndex * shearRate ^ (model.flowBehaviorIndex - 1)
  else if model.modelName = "Bingham Plastic" then
    model.consistencyIndex + model.yieldStress / shearRate
  else
    model.zeroShearViscosity

def zeroScalarField'' := zeroScalarField

def primitiveNonNewtonianFlow : NonNewtonianFlow := {
  flow := primitiveFlow
  viscosityModel := powerLawViscosity
  apparentViscosity := zeroScalarField
  shearRate := zeroScalarField
}

def RheologicalClosure (N : NonNewtonianFlow) : Prop :=
  let model := N.viscosityModel
  N.apparentViscosity = zeroScalarField ∧
  N.shearRate = zeroScalarField ∧
  model.consistencyIndex > 0 ∧
  model.flowBehaviorIndex > 0

theorem primitive_rheological_closure_checked : RheologicalClosure primitiveNonNewtonianFlow := by
  exact And.intro rfl (And.intro rfl (And.intro (by norm_num) (by norm_num)))

end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
end HautevilleHouse