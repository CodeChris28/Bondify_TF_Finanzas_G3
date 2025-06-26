package com.finanzas.bondify.repositories;

import com.finanzas.bondify.entities.BondOperation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface IBondOperationRepository extends JpaRepository<BondOperation, Integer> {
}
