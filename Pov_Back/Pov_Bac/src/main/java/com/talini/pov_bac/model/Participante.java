package com.talini.pov_bac.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Participante {
    @Id@GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private long Documento;
    private String Nome;
    private String Endereco;
    private int NumContato;
    private String Email;
    private boolean Fornecedor;
}
