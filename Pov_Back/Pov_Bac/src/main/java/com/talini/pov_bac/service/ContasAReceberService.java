package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.ContasAReceberRepository;
import com.talini.pov_bac.model.ContasAPagar;
import com.talini.pov_bac.model.ContasAReceber;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContasAReceberService {
    ContasAReceberRepository contasAReceberRepository;
    public ContasAReceberService(ContasAReceberRepository contasAReceberRepository) {this.contasAReceberRepository = contasAReceberRepository; }

    public ContasAReceber getContasAReceberById(int id) {return contasAReceberRepository.findContasAReceberById(id);}
    public List<ContasAReceber> getAllContasAReceber(){return contasAReceberRepository.findAll();}
    public void save(ContasAReceber contas) {contasAReceberRepository.save(contas);}
    public void delete(int id){contasAReceberRepository.deleteById(id);}
}
