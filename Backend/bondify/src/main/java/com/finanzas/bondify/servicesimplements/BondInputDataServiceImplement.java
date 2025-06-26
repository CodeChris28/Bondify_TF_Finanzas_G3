package com.finanzas.bondify.servicesimplements;

import com.finanzas.bondify.entities.BondInputData;
import com.finanzas.bondify.repositories.IBondInputDataRepository;
import com.finanzas.bondify.servicesinterfaces.IBondInputDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BondInputDataServiceImplement implements IBondInputDataService {

    @Autowired
    private IBondInputDataRepository dataR;
    @Override
    public void insert(BondInputData bondInputData) {
        dataR.save(bondInputData);

    }

    @Override
    public List<BondInputData> list() {
        return dataR.findAll();
    }

    @Override
    public void delete(int id) {
        dataR.deleteById(id);

    }

    @Override
    public BondInputData listId(int id) {
        return dataR.findById(id).orElse(new BondInputData());
    }
}
