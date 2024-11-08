package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

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
    @ManyToMany
    @JoinTable(
            name = "id_produto",
            joinColumns = @JoinColumn(name = "preco_id"),
            inverseJoinColumns = @JoinColumn(name = "produto_id")
    )
    @JsonProperty("produto")
    private List<Produto> produto;
    @JsonProperty("Preco")
    private double Preco;
    @JsonProperty("Promocao")
    private boolean Promocao;
}
