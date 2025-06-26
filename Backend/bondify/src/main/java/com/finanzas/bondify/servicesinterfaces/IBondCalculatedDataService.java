package com.finanzas.bondify.servicesinterfaces;
import com.finanzas.bondify.entities.BondCalculatedData;

import java.util.List;

public interface IBondCalculatedDataService {
    public void insert(BondCalculatedData bondCalculatedData);
    public List<BondCalculatedData> list();
    public void delete(int id);
    public BondCalculatedData listId(int id);

}
