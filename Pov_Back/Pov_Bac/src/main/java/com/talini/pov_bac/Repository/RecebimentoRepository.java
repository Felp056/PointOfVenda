package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.Recebimento;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecebimentoRepository extends JpaRepository<Recebimento, Integer> {
    Recebimento findRecebimentoById(int id);
}
