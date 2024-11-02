package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.RecebimentoRepository;
import com.talini.pov_bac.model.Recebimento;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecebimentoService {
    RecebimentoRepository recebimentoRepository;
    public RecebimentoService(RecebimentoRepository recebimentoRepository) {this.recebimentoRepository = recebimentoRepository;}

    public Recebimento getRecebimentoById(int idRecebimento) {return recebimentoRepository.findRecebimentoById(idRecebimento);}
    public List<Recebimento> getAllRecebimentos() {return recebimentoRepository.findAll();}
    public void delete(int idRecebimento) {recebimentoRepository.deleteById(idRecebimento);}
    public void save(Recebimento recebimento) {recebimentoRepository.save(recebimento);}
}
