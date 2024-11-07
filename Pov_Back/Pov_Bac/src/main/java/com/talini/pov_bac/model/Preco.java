package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Preco {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("id")
    private int id;
    @JsonProperty("CodTabela")
    private long CodTabela;
    @JsonProperty("NomeTabela")
    private String NomeTabela;
    @ManyToOne
    @JoinColumn(name = "id_produto_id_produto")
    @JsonProperty("produto")
    private Produto produto;
    @JsonProperty("Preco")
    private double Preco;
    @JsonProperty("Promocao")
    private boolean Promocao;
}
