package com.finanzas.bondify.servicesinterfaces;

import com.finanzas.bondify.entities.GeneralConfiguration;

import java.util.List;

public interface IGeneralConfigurationService {
    public void insert(GeneralConfiguration generalConfiguration);
    public List<GeneralConfiguration> list();
    public void delete(int id);
    public GeneralConfiguration listId(int id);
}
