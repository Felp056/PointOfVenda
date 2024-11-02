package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.Produto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProdutoRepostitory extends JpaRepository<Produto, Integer> {
    Produto findProdutoByIdProduto(int id);
}
