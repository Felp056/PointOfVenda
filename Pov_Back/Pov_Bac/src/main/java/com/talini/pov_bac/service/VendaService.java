package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.VendaRepository;
import com.talini.pov_bac.model.Venda;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VendaService {
    VendaRepository vendaRepository;
    public VendaService(VendaRepository vendaRepository) {this.vendaRepository = vendaRepository;}

    public Venda getVendaByID(int id) {return vendaRepository.findVendaById(id);}
    public List<Venda> getAllVendas() {return vendaRepository.findAll();}
    public void delete(int id){vendaRepository.deleteById(id);}
    public void save(Venda venda){vendaRepository.save(venda);}
}
