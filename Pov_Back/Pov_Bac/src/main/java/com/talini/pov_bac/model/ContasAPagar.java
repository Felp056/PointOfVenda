package com.talini.pov_bac.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Getter
@Setter
public class ContasAPagar {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("id")
    private int id;
    @OneToOne
    @JoinColumn(name = "registro_documento")
    @JsonProperty("Registro")
    private Participante Registro;
    @OneToOne
    @JoinColumn(name = "nome_documento")
    @JsonProperty("Nome")
    private Participante Nome;
    @OneToOne
    @JoinColumn(name = "num_nfe_num_nfe")
    @JsonProperty("NumNFE")
    private Recebimento NumNFE;
    @JsonProperty("Valor")
    private double Valor;
    @JsonProperty("Status")
    private String Status;

}
