package com.finanzas.bondify.repositories;

import com.finanzas.bondify.entities.GeneralConfiguration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IGeneralConfigurationRepository extends JpaRepository<GeneralConfiguration, Integer> {
}
