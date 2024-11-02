package com.talini.pov_bac.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class ContasAReceber {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @OneToOne(optional = false)
    @JoinColumn(name = "documento_documento", nullable = false)
    private Participante Documento;
    @OneToOne
    @JoinColumn(name = "idVenda_idVenda")
    private Venda idVenda;
    private double ValorTotal;
    private int Parcelas;

}
