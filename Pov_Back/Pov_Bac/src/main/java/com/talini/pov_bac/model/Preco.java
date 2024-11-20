package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Set;

@Entity
@Getter
@Setter
public class Preco {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("id")
    private int id;

    @JsonProperty("CodTabela")
    private long codTabela;

    @JsonProperty("NomeTabela")
    private String nomeTabela;

    @JsonProperty("Promocao")
    private boolean promocao;

    // Relação Many-to-Many com Produto (somente produtos existentes)
    @ManyToMany
    @JoinTable(
            name = "produto_preco",
            joinColumns = @JoinColumn(name = "preco_id"),
            inverseJoinColumns = @JoinColumn(name = "produto_id")
    )
    @JsonProperty("Produtos") // Nome esperado no JSON
    private Set<Produto> produtos;
}