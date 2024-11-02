package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.Preco;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PrecoRepostitory extends JpaRepository<Preco, Integer> {
    Preco findPrecoById(int id);
}
