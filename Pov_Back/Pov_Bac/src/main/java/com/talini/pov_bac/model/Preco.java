package com.talini.pov_bac.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Preco {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private long CodTabela;
    private String NomeTabela;
    @ManyToOne
    @JoinColumn(name = "id_produto_id_produto")
    private Produto produto;
    private double Preco;
    private boolean Promocao;
}
