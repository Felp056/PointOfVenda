package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.PrecoRepostitory;
import com.talini.pov_bac.model.Preco;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PrecoService {
    PrecoRepostitory precoRepostitory;
    public PrecoService(PrecoRepostitory precoRepostitory) {this.precoRepostitory = precoRepostitory;}

    public Preco getPrecoById(int id) {return precoRepostitory.findPrecoById(id);}
    public List<Preco> getAllPrecos() {return precoRepostitory.findAll();}
    public void delete(int id){precoRepostitory.deleteById(id);}
    public void save(Preco preco) {precoRepostitory.save(preco);}
}
