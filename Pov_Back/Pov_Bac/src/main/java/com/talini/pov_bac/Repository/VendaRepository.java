package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.Venda;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VendaRepository extends JpaRepository<Venda, Integer> {
    Venda findVendaById(int id);
}
