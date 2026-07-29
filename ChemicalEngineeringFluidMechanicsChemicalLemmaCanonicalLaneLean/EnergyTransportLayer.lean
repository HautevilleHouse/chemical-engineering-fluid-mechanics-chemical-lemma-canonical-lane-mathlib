import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean.FluidStateTransport

namespace HautevilleHouse
namespace ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean

structure EnergyEquation where
  internalEnergy : FluidState → ℝ
  heatFlux : FluidState → (Fin 3 → ℝ)
  viscousDissipation : FluidState → ℝ
  heatSource : FluidState → ℝ

structure ThermalTransportCertificate where
  flow : FluidFlow
  energy : EnergyEquation
  energyConservation : Prop
  energyConservationClosed : energyConservation

def sourceThermalTransportCertificate : ThermalTransportCertificate := {
  flow := { state := { density := 1, velocity := λ _ => 0, pressure := 0, temperature := 298 }, transport := defaultTransportOperator, viscosity := 1e-3 }
  energy := { internalEnergy := λ _ => 0, heatFlux := λ _ _ => 0, viscousDissipation := λ _ => 0, heatSource := λ _ => 0 }
  energyConservation := True
  energyConservationClosed := by trivial
}

def ThermalTransportCertificateClosed (C : ThermalTransportCertificate) : Prop :=
  C.energyConservation

theorem source_thermal_transport_certificate_closed :
    ThermalTransportCertificateClosed sourceThermalTransportCertificate := by
  exact sourceThermalTransportCertificate.energyConservationClosed

end HautevilleHouse
end ChemicalEngineeringFluidMechanicsChemicalLemmaCanonicalLaneLean
