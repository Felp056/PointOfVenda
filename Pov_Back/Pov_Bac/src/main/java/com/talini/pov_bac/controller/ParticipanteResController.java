package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Participante;
import com.talini.pov_bac.service.ParticipanteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/participante")
public class ParticipanteResController {
    private final ParticipanteService participanteService;

    public ParticipanteResController(ParticipanteService participanteService) {
        this.participanteService = participanteService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<Participante>> getAll(){return ResponseEntity.ok(participanteService.getAllParticipantes());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<Participante> getById(@PathVariable("id") int id){ return ResponseEntity.ok(participanteService.getParticipanteById(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        participanteService.delete(id);
        return ResponseEntity.ok("Participante deletado");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody Participante participante)
    {
        participanteService.save(participante);
        return ResponseEntity.ok("Credito salvo com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Participante participante, @RequestParam int id){
        Participante part = participanteService.getParticipanteById(id);
        if(participante == null){
            return ResponseEntity.badRequest().build();
        }else if(part.getDocumento() == participante.getDocumento()){
            if(!participante.getNome().isEmpty() && !participante.getNome().isBlank()){
                part.setNome(participante.getNome());
            }
            if(!participante.getEmail().isEmpty() && !participante.getEmail().isBlank()){
                part.setEmail(participante.getEmail());
            }
            if(!participante.getEndereco().isEmpty() && !participante.getEndereco().isBlank()){
                part.setEndereco(participante.getEndereco());
            }
            part.setFornecedor(participante.isFornecedor());
            if(participante.getNumContato() != 0){
                part.setNumContato(participante.getNumContato());
            }
            participanteService.save(part);
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Participante atualizado");
    }
}
