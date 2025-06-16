package com.finanzas.bondify.dtos;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class GeneralConfigurationDTO {
    private Integer id; // Identificador único de la configuración
    private String defaultCurrency; // Moneda por defecto de la aplicación
    private LocalDateTime createdAt; // Fecha y hora de creación del registro
    private LocalDateTime updatedAt; // Última fecha y hora de actualización
}
