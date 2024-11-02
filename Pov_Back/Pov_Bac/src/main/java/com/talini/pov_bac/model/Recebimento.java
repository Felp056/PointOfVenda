package com.talini.pov_bac.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Recebimento {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private long NumNfe;
    @OneToOne
    @JoinColumn(name = "id_produto_id_produto")
    private Produto idProduto;
    private double ValorTotal;

}
