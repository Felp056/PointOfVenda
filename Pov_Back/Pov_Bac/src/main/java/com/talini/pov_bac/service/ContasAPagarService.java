package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.ContasAPagarRepository;
import com.talini.pov_bac.model.ContasAPagar;
import org.springframework.stereotype.Service;
import java.util.List;
@Service
public class ContasAPagarService {
    ContasAPagarRepository contasAPagarRepository;
    public ContasAPagarService(ContasAPagarRepository contasAPagarRepository) {this.contasAPagarRepository = contasAPagarRepository;}

    public ContasAPagar getContasAPagarById(int id) {return contasAPagarRepository.findContasAPagarById(id);}
    public List<ContasAPagar> getAllContasAPagar(){return contasAPagarRepository.findAll();}
    public void save(ContasAPagar contas) {contasAPagarRepository.save(contas);}
    public void delete(int id){contasAPagarRepository.deleteById(id);}
}
