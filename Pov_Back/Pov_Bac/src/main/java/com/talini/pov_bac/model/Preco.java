package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonManagedReference;
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

    // Configurando o relacionamento muitos-para-muitos com Produtos
    @ManyToMany
    @JoinTable(
            name = "produto_preco", // Nome da tabela intermediária
            joinColumns = @JoinColumn(name = "preco_id"), // Coluna de Preco na tabela intermediária
            inverseJoinColumns = @JoinColumn(name = "produto_id") // Coluna de Produto na tabela intermediária
    )
    @JsonManagedReference  // Gerencia referência circular no JSON
    private Set<Produto> produtos;
}
