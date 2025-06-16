package com.finanzas.bondify.dtos;

import com.finanzas.bondify.entities.BondOperation;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
@Data
public class BondInputDataDTO {
    private Integer id;
    private BondOperation bondOperation;

    private BigDecimal nominalValue; // Valor Nominal del bono
    private BigDecimal commercialValue; // Valor Comercial del bono
    private Integer numberOfYears; // Nº de Años del bono
    private String couponFrequency; // Frecuencia del cupón
    private Integer daysPerYear; // Días x Año
    private BigDecimal interestRate; // Tasa de Interés (el valor numérico)
    private BigDecimal annualDiscountRate; // Tasa anual de descuento
    private BigDecimal incomeTax; // Imp. a la Renta
    private LocalDate issueDate; // Fecha de Emisión

    private BigDecimal initialCostPercent; // % Prima
    private BigDecimal structuringCostPercent; // % Estructuración
    private BigDecimal placementCostPercent; // % Colocación
    private BigDecimal flotationCostPercent; // % Flotación
    private BigDecimal cavaliCostPercent; // % CAVALI

    private String placementCostParty; // Parte que asume el costo de Colocación
    private String flotationCostParty; // Parte que asume el costo de Flotación
    private String cavaliCostParty; // Parte que asume el costo de CAVALI
}
