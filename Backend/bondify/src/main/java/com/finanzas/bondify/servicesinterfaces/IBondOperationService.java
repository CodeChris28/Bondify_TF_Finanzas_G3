package com.finanzas.bondify.servicesinterfaces;


import com.finanzas.bondify.entities.BondOperation;

import java.util.List;

public interface IBondOperationService {
    void insert(BondOperation bondOperation);
    List<BondOperation> list();
    void delete(int id);
    BondOperation listId(int id);

}
