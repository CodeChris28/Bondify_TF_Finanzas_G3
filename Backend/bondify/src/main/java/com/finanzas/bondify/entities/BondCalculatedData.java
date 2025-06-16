package com.finanzas.bondify.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "BondCalculatedData")
public class BondCalculatedData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "operation_id", nullable = false, unique = true)
    private BondOperation bondOperation; // La operación de bono a la que pertenecen estos cálculos

    @Column(name = "coupon_frequency_periods")
    private Integer couponFrequencyPeriods; // Frecuencia del cupón en número de períodos (ej. 2 para Semestral)

    @Column(name = "capitalization_days") //Dias de capitalización
    private Integer capitalizationDays;

    @Column(name = "periods_per_year") //Periodos por año
    private Integer periodsPerYear;

    @Column(name = "total_periods") //Periodos totales
    private Integer totalPeriods;

    @Column(name = "effective_annual_rate", precision = 10, scale = 4)
    private BigDecimal effectiveAnnualRate; // Tasa efectiva anual

    @Column(name = "effective_semestral_rate", precision = 10, scale = 4)
    private BigDecimal effectiveSemestralRate; // Tasa efectiva Semestral

    @Column(name = "cok_semestral", precision = 10, scale = 4)
    private BigDecimal cokSemestral;  // COK Semestral

    @Column(name = "issuer_initial_costs", precision = 18, scale = 2)
    private BigDecimal issuerInitialCosts; // Costes Iniciales Emisor

    @Column(name = "bondholder_initial_costs", precision = 18, scale = 2)
    private BigDecimal bondholderInitialCosts; // Costes Iniciales Bonista

    @Column(name = "actual_price", precision = 18, scale = 2)
    private BigDecimal actualPrice; // Precio Actual

    @Column(name = "utility_loss", precision = 18, scale = 2)
    private BigDecimal utilityLoss; // Utilidad / Pérdida

    @Column(name = "duration", precision = 10, scale = 4)
    private BigDecimal duration; // Duración

    @Column(name = "convexity", precision = 10, scale = 4)
    private BigDecimal convexity; // Convexidad

    @Column(name = "total_duration", precision = 10, scale = 4)
    private BigDecimal totalDuration; // Total

    @Column(name = "modified_duration", precision = 10, scale = 4)
    private BigDecimal modifiedDuration; // Duración modificada

    @Column(name = "tcea_issuer_percent", precision = 10, scale = 4)
    private BigDecimal tceaIssuerPercent; // TCEA Emisor (Tasa de Coste Efectivo Anual desde el punto de vista del emisor)

    @Column(name = "tcea_issuer_with_shield_percent", precision = 10, scale = 4)
    private BigDecimal tceaIssuerWithShieldPercent; // TCEA Emisor c/Escudo

    @Column(name = "trea_bondholder_percent", precision = 10, scale = 4)
    private BigDecimal treaBondholderPercent; // TREA Bonista (Tasa de Rendimiento Efectivo Anual desde el punto de vista del bonista o inversor)

    @Column(name = "trea_bondholder_with_shield_percent", precision = 10, scale = 4)
    private BigDecimal treaBondholderWithShieldPercent; // TREA Bonista c/Escudo
}