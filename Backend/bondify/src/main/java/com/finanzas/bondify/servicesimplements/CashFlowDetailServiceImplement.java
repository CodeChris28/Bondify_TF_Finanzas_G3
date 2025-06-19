package com.finanzas.bondify.servicesimplements;

import com.finanzas.bondify.entities.CashFlowDetail;
import com.finanzas.bondify.repositories.ICashFlowDetailRepository;
import com.finanzas.bondify.servicesinterfaces.ICashFlowDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CashFlowDetailServiceImplement implements ICashFlowDetailService {

    @Autowired
    private ICashFlowDetailRepository cR;

    @Override
    public void insert(CashFlowDetail cashFlowDetail) {
        cR.save(cashFlowDetail);
    }
//retorna todos los registros existentes
    @Override
    public List<CashFlowDetail> list() {
        return cR.findAll();
    }

    @Override
    public void delete(int id) {
        cR.deleteById(id);
    }

    //Retorna un flujo por su ID; si no lo encuentra, devuelve uno vacío.
    @Override
    public CashFlowDetail listId(int id) {
        return cR.findById(id).orElse(new CashFlowDetail());
    }
}
