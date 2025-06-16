package com.finanzas.bondify.controllers;

import com.finanzas.bondify.dtos.GeneralConfigurationDTO;
import com.finanzas.bondify.entities.GeneralConfiguration;
import com.finanzas.bondify.servicesinterfaces.IGeneralConfigurationService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/config")
public class GeneralConfigurationController {
    @Autowired
    private IGeneralConfigurationService cS;

    @PostMapping
    public void insertConfig(@RequestBody GeneralConfigurationDTO configdto) {
        ModelMapper m = new ModelMapper();
        GeneralConfiguration config = m.map(configdto, GeneralConfiguration.class);
        cS.insert(config);
    }

    @PutMapping
    public void updateConfig(@RequestBody GeneralConfigurationDTO configdto) {
        ModelMapper m = new ModelMapper();
        GeneralConfiguration config = m.map(configdto, GeneralConfiguration.class);
        cS.insert(config);
    }

    @GetMapping
    public List<GeneralConfigurationDTO> getAllConfigs() {
        return cS.list().stream().map(c ->{
            ModelMapper m = new ModelMapper();
            return m.map(c, GeneralConfigurationDTO.class);
        }).collect(Collectors.toList());
    }

    @DeleteMapping("/{id}")
    public void deleteConfig(@PathVariable("id") Integer id) {cS.delete(id);}

    @GetMapping("/{id}")
    public GeneralConfigurationDTO getConfig(@PathVariable("id") Integer id) {
        ModelMapper m = new ModelMapper();
        GeneralConfigurationDTO dto = m.map(cS.listId(id),GeneralConfigurationDTO.class);
        return dto;
    }
}
