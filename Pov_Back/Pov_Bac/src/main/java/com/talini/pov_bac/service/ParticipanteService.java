package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.ParticipanteRepository;
import com.talini.pov_bac.model.Participante;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ParticipanteService {
    ParticipanteRepository participanteRepository;
    public ParticipanteService(ParticipanteRepository participanteRepository) {this.participanteRepository = participanteRepository;}

    public Participante getParticipanteById(int id) {return participanteRepository.findParticipanteById(id);}
    public List<Participante> getAllParticipantes(){return participanteRepository.findAll();}
    public void save(Participante participante) {participanteRepository.save(participante);}
    public void delete(int id){participanteRepository.deleteById(id);}
}
