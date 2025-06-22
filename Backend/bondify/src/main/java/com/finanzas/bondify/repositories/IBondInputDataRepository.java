package com.finanzas.bondify.repositories;

import com.finanzas.bondify.entities.BondInputData;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IBondInputDataRepository extends JpaRepository<BondInputData, Integer> {

}
