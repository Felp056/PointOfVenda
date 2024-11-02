package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.Participante;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ParticipanteRepository extends JpaRepository<Participante, Integer> {
    Participante findParticipanteById(Integer id);
}
