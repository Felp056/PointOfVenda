package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Credito {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("id")
    private int id;
    @OneToOne(optional = false)
    @JoinColumn(name = "documento_documento", nullable = false)
    @JsonProperty("Documento")
    private Participante Documento;
    @OneToOne
    @JoinColumn(name = "nome_nome")
    @JsonProperty("Nome")
    private Participante Nome;
    @JsonProperty("TotCredito")
    private double TotCredito;
    @JsonProperty("CreditoConsumido")
    private double CreditoConsumido;

}
