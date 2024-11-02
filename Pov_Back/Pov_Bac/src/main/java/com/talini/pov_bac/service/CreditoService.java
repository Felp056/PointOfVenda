package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.CreditoRepository;
import com.talini.pov_bac.model.Credito;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CreditoService {
    CreditoRepository creditoRepository;
    public CreditoService(CreditoRepository creditoRepository) {this.creditoRepository = creditoRepository;}

    public Credito getCreditoById(int id) {return creditoRepository.findCreditoById(id);}
    public List<Credito> getAllCreditos() {return creditoRepository.findAll();}
    public void delete(int id){creditoRepository.deleteById(id);}
    public void save(Credito credito) {creditoRepository.save(credito);}
}
