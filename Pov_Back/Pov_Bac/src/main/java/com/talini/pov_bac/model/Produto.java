package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Set;

@Entity
@Getter
@Setter
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("idProduto")
    private int idProduto;

    @JsonProperty("Descricao")
    private String descricao;

    @JsonProperty("CodBarras")
    private long codBarras;

    @JsonProperty("QtdDisponivel")
    private long qtdDisponivel;

    @JsonProperty("Medida")
    private String medida;

    @JsonProperty("Preco")
    private double preco;

    // Configurando o relacionamento muitos-para-muitos com Tabela de Preços
    @ManyToMany(mappedBy = "produtos")
    @JsonBackReference  // Evita referência circular na serialização JSON
    private Set<Preco> precos;
}
