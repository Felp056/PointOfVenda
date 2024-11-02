package com.talini.pov_bac.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Credito {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @OneToOne(optional = false)
    @JoinColumn(name = "documento_documento", nullable = false)
    private Participante Documento;
    @OneToOne
    @JoinColumn(name = "nome_nome")
    private Participante Nome;
    private double TotCredito;
    private double CreditoConsumido;

}
