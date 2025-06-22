package com.finanzas.bondify.servicesinterfaces;

import com.finanzas.bondify.entities.BondInputData;

import java.util.List;

public interface IBondInputDataService {
    public void insert(BondInputData bondInputData);
    public List<BondInputData> list();
    public void delete(int id);
    public BondInputData listId(int id);
}
