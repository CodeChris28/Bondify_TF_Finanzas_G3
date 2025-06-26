package com.finanzas.bondify.controllers;

import com.finanzas.bondify.dtos.BondCalculatedDataDTO;
import com.finanzas.bondify.entities.BondCalculatedData;
import com.finanzas.bondify.servicesinterfaces.IBondCalculatedDataService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/bondData")

public class BondCalculatedDataController {
    @Autowired
    private IBondCalculatedDataService bRService;
    @PostMapping
    public void insertBondCalculatedData(@RequestBody BondCalculatedDataDTO bondCalculatedDataDTO) {
        ModelMapper m = new ModelMapper();
        BondCalculatedData calculatedData = m.map(bondCalculatedDataDTO, BondCalculatedData.class);
        bRService.insert(calculatedData);
    }

    @PutMapping
    public void updateBondCalculatedData(@RequestBody BondCalculatedDataDTO bondCalculatedDTO) {
        ModelMapper m = new ModelMapper();
        BondCalculatedData calculatedData = m.map(bondCalculatedDTO, BondCalculatedData.class);
        bRService.insert(calculatedData);
    }

    @GetMapping
    public List<BondCalculatedDataDTO> getAllBondCalculatedData() {
        return bRService.list().stream().map(b -> {
            ModelMapper m = new ModelMapper();
            return m.map(b, BondCalculatedDataDTO.class);
        }).collect(Collectors.toList());
    }

    @DeleteMapping("/{id}")
    public void deleteBondCalculatedData(@PathVariable("id") Integer id) {
        bRService.delete(id);
    }

    @GetMapping("/{id}")
    public BondCalculatedDataDTO getBondCalculatedData(@PathVariable("id") Integer id) {
        ModelMapper m = new ModelMapper();
        BondCalculatedDataDTO bondCalculatedDataDTO = m.map(bRService.listId(id), BondCalculatedDataDTO.class);
        return bondCalculatedDataDTO;
    }
}
