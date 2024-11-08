package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Collection;

@Entity
@Getter
@Setter
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("idProduto")
    private int idProduto;
    @JsonProperty("Descricao")
    private String Descricao;
    @JsonProperty("CodBarras")
    private long CodBarras;
    @JsonProperty("QtdDisponivel")
    private long QtdDisponivel;
    @JsonProperty("Medida")
    private String Medida;
    @ManyToMany(mappedBy = "produto")
    private Collection<Preco> precos;

    public Collection<Preco> getPrecos() {
        return precos;
    }

    public void setPrecos(Collection<Preco> precos) {
        this.precos = precos;
    }
}
