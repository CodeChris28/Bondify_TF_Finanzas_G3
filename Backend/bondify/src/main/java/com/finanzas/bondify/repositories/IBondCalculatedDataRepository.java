package com.finanzas.bondify.repositories;

import com.finanzas.bondify.entities.BondCalculatedData;

import org.springframework.data.jpa.repository.JpaRepository;

public interface IBondCalculatedDataRepository extends JpaRepository<BondCalculatedData, Integer> {
}
