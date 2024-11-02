package com.talini.pov_bac.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class ContasAPagar {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @OneToOne
    @JoinColumn(name = "registro_documento")
    private Participante Registro;
    @OneToOne
    @JoinColumn(name = "nome_documento")
    private Participante Nome;
    @OneToOne
    @JoinColumn(name = "num_nfe_num_nfe")
    private Recebimento NumNFE;
    private double Valor;
    private String Status;

}
