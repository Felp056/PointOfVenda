package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.ContasAPagar;
import com.talini.pov_bac.service.ContasAPagarService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/contasapagar")
public class ContasAPagarRestController {
    private final ContasAPagarService contasAPagarService;

    public ContasAPagarRestController(ContasAPagarService contasAPagarService) {
        this.contasAPagarService = contasAPagarService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<ContasAPagar>> getAll(){return ResponseEntity.ok(contasAPagarService.getAllContasAPagar());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<ContasAPagar> getById(@PathVariable("id") int id){ return ResponseEntity.ok(contasAPagarService.getContasAPagarById(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        contasAPagarService.delete(id);
        return ResponseEntity.ok("Conta a pagar deletada");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody ContasAPagar contasAPagar)
    {
        contasAPagarService.save(contasAPagar);
        return ResponseEntity.ok("Salva com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody ContasAPagar contasAPagar, @RequestParam int id){
        ContasAPagar cont = contasAPagarService.getContasAPagarById(id);
        if(cont.getRegistro() == contasAPagar.getRegistro()){
            if(contasAPagar.getNome() != null){
                cont.setNome(contasAPagar.getNome());
            }
            if(contasAPagar.getValor() > 0){
                cont.setValor(contasAPagar.getValor());
            }
            if(contasAPagar.getNumNFE() != null){
                cont.setNumNFE(contasAPagar.getNumNFE());
            }
            cont.setStatus(contasAPagar.getStatus());
            contasAPagarService.save(cont);
        }else if(contasAPagar == null){
            return ResponseEntity.badRequest().build();
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Conta a pagar atualizada");
    }
}
