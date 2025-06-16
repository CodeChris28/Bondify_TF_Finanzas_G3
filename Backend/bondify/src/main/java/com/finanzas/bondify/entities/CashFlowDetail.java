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
@Table(name = "CashFlowDetail")
public class CashFlowDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY) // Muchos detalles para una operación
    @JoinColumn(name = "operation_id", nullable = false)
    private BondOperation bondOperation;

    @Column(name = "period_number", nullable = false)
    private Integer periodNumber; //Nº de periodo

    @Column(name = "date", nullable = false)
    private LocalDate date; //Fecha progrmada
    @Column(name = "inflation_semestral", precision = 10, scale = 4)
    private BigDecimal inflationSemestral; //Inflación Semestral

    @Column(name = "grace_period_flag")
    private Boolean gracePeriodFlag; // true/false para indicar si es periodo de gracia

    @Column(name = "bond", precision = 18, scale = 2)
    private BigDecimal bond; //Bono

    @Column(name = "indexed_bond", precision = 18, scale = 2)
    private BigDecimal indexedBond; //Bono Indexado

    @Column(name = "interest", precision = 18, scale = 2)
    private BigDecimal interest; //Intereses

    @Column(name = "quota", precision = 18, scale = 2)
    private BigDecimal quota; //Cuota

    @Column(name = "amortization", precision = 18, scale = 2)
    private BigDecimal amortization; //Amortización

    @Column(name = "shield", precision = 18, scale = 2)
    private BigDecimal shield; //Escudo

    @Column(name = "issuer_cash_flow", precision = 18, scale = 2)
    private BigDecimal issuerCashFlow; //Flujo Emisor

    @Column(name = "issuer_cash_flow_c_shield", precision = 18, scale = 2)
    private BigDecimal issuerCashFlowCShield; //Flujo Emisor c/ escudo

    @Column(name = "bondholder_cash_flow", precision = 18, scale = 2)
    private BigDecimal bondholderCashFlow; //Flujo Bonista

    @Column(name = "actual_cash_flow", precision = 18, scale = 2)
    private BigDecimal actualCashFlow; //Flujo actual

    @Column(name = "pv_convexity", precision = 18, scale = 2)
    private BigDecimal pvConvexity; //PV convexividad
}
