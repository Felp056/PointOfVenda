package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.Credito;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CreditoRepository extends JpaRepository<Credito, Integer> {
    Credito findCreditoById(int id);
}
