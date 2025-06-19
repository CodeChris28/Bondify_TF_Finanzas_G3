package com.finanzas.bondify.repositories;

import com.finanzas.bondify.entities.CashFlowDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ICashFlowDetailRepository extends JpaRepository<CashFlowDetail, Integer> {
    // Aquí puedes agregar métodos personalizados si lo necesitas

    /**
     * Obtiene todos los flujos de caja asociados a una operación de bono específica,
     * ordenados por número de período.
     *
     * @param bondOperationId ID de la operación de bono
     * @return lista de flujos de caja correspondientes
     */
    List<CashFlowDetail> findByBondOperationIdOrderByPeriodNumberAsc(Integer bondOperationId);

    /**
     * Busca flujos de caja en un rango de fechas.
     *
     * @param startDate fecha de inicio
     * @param endDate   fecha de fin
     * @return lista de flujos entre las fechas especificadas
     */
    List<CashFlowDetail> findByDateBetween(LocalDate startDate, LocalDate endDate);

    /**
     * Filtra los flujos que tienen periodo de gracia activado.
     *
     * @param gracePeriodFlag valor booleano (true o false)
     * @return lista de flujos según el valor del periodo de gracia
     */
    List<CashFlowDetail> findByGracePeriodFlag(Boolean gracePeriodFlag);
}
