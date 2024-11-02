package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.ContasAPagar;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContasAPagarRepository extends JpaRepository<ContasAPagar, Integer> {
    ContasAPagar findContasAPagarById(int id);
}
