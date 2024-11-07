package com.talini.pov_bac.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Getter
@Setter

public class Participante {
    @Id@GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("id")
    private int id;
    @JsonProperty("Documento")
    private long Documento;
    @JsonProperty("Nome")
    private String Nome;
    @JsonProperty("Endereco")
    private String Endereco;
    @JsonProperty("NumContato")
    private int NumContato;
    @JsonProperty("Email")
    private String Email;
    @JsonProperty("Fornecedor")
    private boolean Fornecedor;
}
