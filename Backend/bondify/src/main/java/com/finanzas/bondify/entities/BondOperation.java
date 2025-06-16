package com.finanzas.bondify.entities;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "BondOperations")
public class BondOperation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY) // Muchas operaciones para un usuario
    @JoinColumn(name = "user_id", nullable = false) // LLave foránea
    private User user;

    @Column(name = "operation_name", length = 255, nullable = false)
    private String operationName; //Nombre de la operación

    @Column(name = "bond_method", length = 50, nullable = false)
    private String bondMethod; //Metodo de cálculo de Bono ( Americano, Aleman, Francés) Por ahora solo Frances pero es escalable

    @Column(name = "currency", length = 10, nullable = false) // "PEN", "USD"
    private String currency; //Moneda especifica de la operacion

    @Column(name = "interest_rate_type", length = 50, nullable = false)
    private String interestRateType; // Tasa de interes "Efectiva", "Nominal"

    @Column(name = "capitalization_period", length = 50)
    private String capitalizationPeriod; // "Anual", "Semestral", "Mensual", etc. Puede ser nulo

    @Column(name = "grace_period_type", length = 50)
    private String gracePeriodType; // "Total", "Parcial", "Ninguno"

    @Column(name = "grace_period_start_date")
    private LocalDate gracePeriodStartDate; //Inicio del Periodo de Gracia

    @Column(name = "grace_period_end_date")
    private LocalDate gracePeriodEndDate; //Final del periodo de gracia

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

}