package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.ContasAReceber;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContasAReceberRepository extends JpaRepository<ContasAReceber, Integer> {
    ContasAReceber findContasAReceberById(int id);
}
