package com.finanzas.bondify.dtos;

import com.finanzas.bondify.entities.BondOperation;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
@Data
public class CashFlowDetailDTO {
    private Integer id;

    private Integer bondOperationId;
    //private BondOperation bondOperation;

    private Integer periodNumber; // Nº (Número de período)
    private LocalDate date; // Fecha
    private BigDecimal inflationSemestral; // Inflación Semestral
    private Boolean gracePeriodFlag; // Indicador S/N para Plazo de Gracia
    private BigDecimal bond; // Bono
    private BigDecimal indexedBond; // Bono Indexado
    private BigDecimal interest; // Interes
    private BigDecimal quota; // Cuota
    private BigDecimal amortization; // Amort.
    private BigDecimal shield; // Escudo
    private BigDecimal issuerCashFlow; // Flujo Emisor
    private BigDecimal issuerCashFlowCShield; // Flujo Emisor c/Escudo
    private BigDecimal bondholderCashFlow; // Flujo Bonista
    private BigDecimal actualCashFlow; // Flujo Act. FA x Plazo
    private BigDecimal pvConvexity; // PV / Convexidad
}
