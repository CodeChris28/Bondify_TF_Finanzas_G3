package com.finanzas.bondify.dtos;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class UserDTO {
    private Integer id;
    private String username;
    private String email;
    private String password;
    private LocalDateTime createdAt; // Fecha y hora de creación del usuario
    private LocalDateTime updatedAt; // Última fecha y hora de actualización
}
