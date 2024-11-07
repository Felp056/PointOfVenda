package com.talini.pov_bac.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Recebimento {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @JsonProperty("id")
    private int id;
    @JsonProperty("NumNfe")
    private long NumNfe;
    @OneToOne
    @JoinColumn(name = "id_produto_id_produto")
    @JsonProperty("idProduto")
    private Produto idProduto;
    @JsonProperty("ValorTotal")
    private double ValorTotal;

}
