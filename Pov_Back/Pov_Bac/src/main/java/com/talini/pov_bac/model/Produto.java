package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
    private String Descricao;
    @JsonProperty("CodBarras")
    private long CodBarras;
    @JsonProperty("QtdDisponivel")
    private long QtdDisponivel;
    @JsonProperty("Medida")
    private String Medida;
}
