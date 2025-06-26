package com.finanzas.bondify.controllers;


import com.finanzas.bondify.entities.BondOperation;
import com.finanzas.bondify.servicesinterfaces.IBondOperationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bondoperations")
public class BondOperationController {
    @Autowired
    private IBondOperationService bondOperationService;

    //  Insertar una operación de bono
    @PostMapping
    public void insert(@RequestBody BondOperation bondOperation) {
        bondOperationService.insert(bondOperation);
    }

    //  Listar todas las operaciones
    @GetMapping
    public List<BondOperation> list() {
        return bondOperationService.list();
    }

    // Buscar operación por ID
    @GetMapping("/{id}")
    public BondOperation getById(@PathVariable("id") int id) {
        return bondOperationService.listId(id);
    }

    //  Eliminar operación por ID
    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") int id) {
        bondOperationService.delete(id);
    }

}
