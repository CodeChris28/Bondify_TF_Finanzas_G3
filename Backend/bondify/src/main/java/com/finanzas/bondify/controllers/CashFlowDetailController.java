package com.finanzas.bondify.controllers;

import com.finanzas.bondify.dtos.CashFlowDetailDTO;
import com.finanzas.bondify.entities.CashFlowDetail;
import com.finanzas.bondify.servicesinterfaces.ICashFlowDetailService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController 
@RequestMapping("/cashflow")
public class CashFlowDetailController {
    @Autowired
    private ICashFlowDetailService cS;

    /**
     * Inserta un nuevo flujo de caja.
     * Se recibe un DTO, se convierte a entidad, y se guarda mediante el servicio.
     */
    @PostMapping
    public void insertCashFlow(@RequestBody CashFlowDetailDTO cashflowDTO) {
        ModelMapper m = new ModelMapper();
        CashFlowDetail cashflow = m.map(cashflowDTO, CashFlowDetail.class);
        cS.insert(cashflow);
    }

    /**
     * Actualiza un flujo de caja existente.
     * En este caso, se utiliza el mismo método insert() para actualizar si el ID ya existe.
     */
    @PutMapping
    public void updateCashFlow(@RequestBody CashFlowDetailDTO cashflowDTO) {
        ModelMapper m = new ModelMapper();
        CashFlowDetail cashflow = m.map(cashflowDTO, CashFlowDetail.class);
        cS.insert(cashflow); // se reutiliza insert para actualizar
    }

    /**
     * Lista todos los flujos de caja registrados.
     * Convierte cada entidad a DTO usando ModelMapper.
     */
    @GetMapping
    public List<CashFlowDetailDTO> getAllCashFlows() {
        return cS.list().stream().map(c -> {
            ModelMapper m = new ModelMapper();
            return m.map(c, CashFlowDetailDTO.class);
        }).collect(Collectors.toList());
    }

    /**
     * Elimina un flujo de caja por su identificador.
     */
    @DeleteMapping("/{id}")
    public void deleteCashFlow(@PathVariable("id") Integer id) {
        cS.delete(id);
    }

    /*
     Busca un flujo de caja por su identificador y devuelve su representación en DTO.
     */
    @GetMapping("/{id}")
    public CashFlowDetailDTO getCashFlowById(@PathVariable("id") Integer id) {
        ModelMapper m = new ModelMapper();
        CashFlowDetailDTO dto = m.map(cS.listId(id), CashFlowDetailDTO.class);
        return dto;
    }
}
