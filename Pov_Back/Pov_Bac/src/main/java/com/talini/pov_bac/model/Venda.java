package com.talini.pov_bac.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Venda {
    @Id
    private long id;
    private long idPedido;
    private double ValorPedido;
    private String FormaPagamento;
    private double CreditoDisponivel;

}
