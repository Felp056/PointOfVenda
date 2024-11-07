package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class ContasAReceber {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("id")
    private int id;
    @OneToOne(optional = false)
    @JoinColumn(name = "documento_documento", nullable = false)
    @JsonProperty("Documento")
    private Participante Documento;
    @OneToOne
    @JoinColumn(name = "idVenda_idVenda")
    @JsonProperty("idVenda")
    private Venda idVenda;
    @JsonProperty("ValorTotal")
    private double ValorTotal;
    @JsonProperty("Parcelas")
    private int Parcelas;

}
