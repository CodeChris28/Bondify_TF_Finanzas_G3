package com.finanzas.bondify.dtos;

import com.finanzas.bondify.entities.User;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
@Data
public class BondOperationDTO {
    private Integer id;
    private User user;

    private String operationName;
    private String bondMethod;
    private String currency; // Moneda específica de esta operación
    private String interestRateType; // Tipo de tasa de interés para esta operación
    private String capitalizationPeriod; // Período de capitalización (nulo si es efectiva)
    private String gracePeriodType; // Tipo de plazo de gracia (Total, Parcial, Ninguno)
    private LocalDate gracePeriodStartDate; // Fecha de inicio del plazo de gracia
    private LocalDate gracePeriodEndDate; // Fecha de fin del plazo de gracia
    private LocalDateTime createdAt; // Fecha y hora de creación de la operación
    private LocalDateTime updatedAt; // Última fecha y hora de actualización
}
