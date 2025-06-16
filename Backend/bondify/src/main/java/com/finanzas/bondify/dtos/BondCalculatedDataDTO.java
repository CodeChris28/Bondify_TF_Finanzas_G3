package com.finanzas.bondify.dtos;

import com.finanzas.bondify.entities.BondOperation;
import lombok.Data;

import java.math.BigDecimal;
@Data
public class BondCalculatedDataDTO {
    private Integer id;


    private BondOperation bondOperation;

    private Integer couponFrequencyPeriods; // Frecuencia del cupón en número de períodos
    private Integer capitalizationDays; // Días capitalización
    private Integer periodsPerYear; // Nº Períodos por Año
    private Integer totalPeriods; // Nº Total de Períodos
    private BigDecimal effectiveAnnualRate; // Tasa efectiva anual
    private BigDecimal effectiveSemestralRate; // Tasa efectiva Semestral
    private BigDecimal cokSemestral; // COK Semestral
    private BigDecimal issuerInitialCosts; // Costes Iniciales Emisor
    private BigDecimal bondholderInitialCosts; // Costes Iniciales Bonista
    private BigDecimal actualPrice; // Precio Actual
    private BigDecimal utilityLoss; // Utilidad / Pérdida
    private BigDecimal duration; // Duración
    private BigDecimal convexity; // Convexidad
    private BigDecimal totalDuration; // Total
    private BigDecimal modifiedDuration; // Duración modificada
    private BigDecimal tceaIssuerPercent; // TCEA Emisor
    private BigDecimal tceaIssuerWithShieldPercent; // TCEA Emisor c/Escudo
    private BigDecimal treaBondholderPercent; // TREA Bonista
    private BigDecimal treaBondholderWithShieldPercent; // TREA Bonista c/Escudo
}
