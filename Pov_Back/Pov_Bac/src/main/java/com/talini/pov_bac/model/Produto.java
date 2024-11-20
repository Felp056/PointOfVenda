package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

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
}
