package com.finanzas.bondify.servicesimplements;

import com.finanzas.bondify.entities.BondCalculatedData;
import com.finanzas.bondify.repositories.IBondCalculatedDataRepository;
import com.finanzas.bondify.servicesinterfaces.IBondCalculatedDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BondCalculatedDataServiceImplement implements IBondCalculatedDataService {
    @Autowired
    private IBondCalculatedDataRepository bR;


    @Override
    public void insert(BondCalculatedData bondCalculatedData) {
        bR.save(bondCalculatedData);
    }

    @Override
    public List<BondCalculatedData> list() {
        return bR.findAll();
    }

    @Override
    public void delete(int id) {
        bR.deleteById(id);

    }

    @Override
    public BondCalculatedData listId(int id) {
        return bR.findById(id).orElse(new BondCalculatedData());
    }


}
