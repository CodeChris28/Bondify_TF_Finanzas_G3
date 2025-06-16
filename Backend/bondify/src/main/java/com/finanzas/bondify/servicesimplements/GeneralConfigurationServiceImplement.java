package com.finanzas.bondify.servicesimplements;

import com.finanzas.bondify.entities.GeneralConfiguration;
import com.finanzas.bondify.repositories.IGeneralConfigurationRepository;
import com.finanzas.bondify.servicesinterfaces.IGeneralConfigurationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GeneralConfigurationServiceImplement implements IGeneralConfigurationService {
    @Autowired
    private IGeneralConfigurationRepository gR;
    @Override
    public void insert(GeneralConfiguration generalConfiguration) {
        gR.save(generalConfiguration);
    }

    @Override
    public List<GeneralConfiguration> list() {
        return gR.findAll();
    }

    @Override
    public void delete(int id) { gR.deleteById(id); }

    @Override
    public GeneralConfiguration listId(int id) {
        return gR.findById(id).orElse(new GeneralConfiguration());
    }
}
