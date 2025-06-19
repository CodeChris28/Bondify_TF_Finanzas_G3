package com.finanzas.bondify.servicesinterfaces;

import com.finanzas.bondify.entities.CashFlowDetail;

import java.util.List;

public interface ICashFlowDetailService {
    public void insert(CashFlowDetail cashFlowDetail);
    public List<CashFlowDetail> list();
    public void delete(int id);
    public CashFlowDetail listId(int id);
}
