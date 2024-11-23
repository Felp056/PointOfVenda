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
    @JsonProperty("id")
    private long id;
    @JsonProperty("idPedido")
    private long idPedido;
    @JsonProperty("ValorPedido")
    private double ValorPedido;
    @JsonProperty("FormaPagamento")
    private String FormaPagamento;
    @JsonProperty("CreditoDisponivel")
    private double CreditoDisponivel;

}
