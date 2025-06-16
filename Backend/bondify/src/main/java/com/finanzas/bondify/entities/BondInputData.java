package com.finanzas.bondify.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "BondInputData")
public class BondInputData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "operation_id", nullable = false, unique = true)
    private BondOperation bondOperation; // La operación de bono a la que pertenecen estos datos

    @Column(name = "nominal_value", precision = 18, scale = 2, nullable = false)
    private BigDecimal nominalValue; // Valor Nominal del bono

    @Column(name = "commercial_value", precision = 18, scale = 2, nullable = false)
    private BigDecimal commercialValue; // Valor Comercial del bono

    @Column(name = "number_of_years", nullable = false)
    private Integer numberOfYears; // Nº de Años del bono

    @Column(name = "coupon_frequency", length = 50, nullable = false) // "Semestral", "Anual", "Trimestral"
    private String couponFrequency; // Frecuencia del bono (ej. "Semestral", "Anual", "Trimestral")

    @Column(name = "days_per_year", nullable = false)
    private Integer daysPerYear; //Días x Año (ej. 360)

    @Column(name = "interest_rate", precision = 10, scale = 4, nullable = false)
    private BigDecimal interestRate; // Tasa de Interés (el valor numérico, ej. 9.000%)

    @Column(name = "annual_discount_rate", precision = 10, scale = 4)
    private BigDecimal annualDiscountRate; // Tasa anual de descuento (ej. 6.000%)

    @Column(name = "income_tax", precision = 5, scale = 2, nullable = false)
    private BigDecimal incomeTax; // Imp. a la Renta (Impuesto a la Renta, ej. 30%)

    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate; // Fecha de Emisión del bono

    // Costos en porcentaje (ej. 1.000%)
    @Column(name = "initial_cost_percent", precision = 5, scale = 2)
    private BigDecimal initialCostPercent; // % Prima

    @Column(name = "structuring_cost_percent", precision = 5, scale = 2)
    private BigDecimal structuringCostPercent; // % Estructuración

    @Column(name = "placement_cost_percent", precision = 5, scale = 2)
    private BigDecimal placementCostPercent; // % Colocación

    @Column(name = "flotation_cost_percent", precision = 5, scale = 2)
    private BigDecimal flotationCostPercent; // % Flotación

    @Column(name = "cavali_cost_percent", precision = 5, scale = 2)
    private BigDecimal cavaliCostPercent; // % CAVALI

    // Partes involucradas en el costo (Emisor/Ambos)
    @Column(name = "placement_cost_party", length = 50)
    private String placementCostParty; // Parte que asume el costo de Colocación

    @Column(name = "flotation_cost_party", length = 50)
    private String flotationCostParty; // Parte que asume el costo de Flotación

    @Column(name = "cavali_cost_party", length = 50)
    private String cavaliCostParty; // Parte que asume el costo de CAVALI
}
