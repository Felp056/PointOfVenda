package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Venda {
    @Id
    @JsonProperty("NivelAcesso")
    private long id;
    @JsonProperty("NivelAcesso")
    private long idPedido;
    @JsonProperty("NivelAcesso")
    private double ValorPedido;
    @JsonProperty("NivelAcesso")
    private String FormaPagamento;
    @JsonProperty("CreditoDisponivel")
    private double CreditoDisponivel;

}
