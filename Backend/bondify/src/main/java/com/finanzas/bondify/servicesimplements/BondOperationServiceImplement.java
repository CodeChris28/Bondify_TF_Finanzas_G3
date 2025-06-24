package com.finanzas.bondify.servicesimplements;

import com.finanzas.bondify.entities.BondOperation;
import com.finanzas.bondify.repositories.IBondOperationRepository;
import com.finanzas.bondify.servicesinterfaces.IBondOperationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BondOperationServiceImplement implements IBondOperationService {

    @Autowired
    private IBondOperationRepository bR;

    @Override
    public void insert(BondOperation bondOperation) {
        bondOperation.setCreatedAt(LocalDateTime.now());
        bondOperation.setUpdatedAt(LocalDateTime.now());
        bR.save(bondOperation);
    }

    @Override
    public List<BondOperation> list() {
        return bR.findAll();
    }

    @Override
    public void delete(int id) {
        bR.deleteById(id);
    }

    @Override
    public BondOperation listId(int id) {
        return bR.findById(id).orElse(new BondOperation());
    }
}
