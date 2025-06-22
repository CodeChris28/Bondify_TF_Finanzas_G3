package com.finanzas.bondify.controllers;

import com.finanzas.bondify.dtos.BondInputDataDTO;
import com.finanzas.bondify.entities.BondInputData;
import com.finanzas.bondify.servicesinterfaces.IBondInputDataService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/inputData")
public class BondInputDataController {
    @Autowired
    private IBondInputDataService dataService;

    @PostMapping
    public void insertBondInputData(@RequestBody BondInputDataDTO bondInputDataDTO) {
        ModelMapper m = new ModelMapper();
        BondInputData inputData = m.map(bondInputDataDTO, BondInputData.class);
        dataService.insert(inputData);
    }

    @PutMapping
    public void updateBondInputData(@RequestBody BondInputDataDTO bondInputDataDTO) {
        ModelMapper m = new ModelMapper();
        BondInputData inputData = m.map(bondInputDataDTO, BondInputData.class);
        dataService.insert(inputData);

    }

    @GetMapping
    public List<BondInputDataDTO> getAllBondInputData(){
        return dataService.list().stream().map( d ->{
            ModelMapper m = new ModelMapper();
            return m.map(d, BondInputDataDTO.class);
        }).collect(Collectors.toList());
    }
}
