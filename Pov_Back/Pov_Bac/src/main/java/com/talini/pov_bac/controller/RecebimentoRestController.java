package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Recebimento;
import com.talini.pov_bac.service.RecebimentoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/recebimento")
public class RecebimentoRestController {
    private final RecebimentoService recebimentoService;

    public RecebimentoRestController(RecebimentoService recebimentoService) {
        this.recebimentoService = recebimentoService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<Recebimento>> getAll(){return ResponseEntity.ok(recebimentoService.getAllRecebimentos());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<Recebimento> getById(@PathVariable("id") int id){ return ResponseEntity.ok(recebimentoService.getRecebimentoById(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        recebimentoService.delete(id);
        return ResponseEntity.ok("Recebimento deletado");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody Recebimento recebimento)
    {
        recebimentoService.save(recebimento);
        return ResponseEntity.ok("Recebimento salvo com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Recebimento recebimento, @RequestParam int id){
        Recebimento recebe = recebimentoService.getRecebimentoById(id);
        if(recebimento == null){
            return ResponseEntity.badRequest().build();
        }else if(recebimento.getNumNfe() == recebe.getNumNfe()){
            if(recebimento.getIdProduto() == null){
                recebe.setIdProduto(recebimento.getIdProduto());
            }
            if(recebimento.getValorTotal() > 0){
                recebe.setValorTotal(recebimento.getValorTotal());
            }
            recebimentoService.save(recebe);
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Recebimento atualizado");
    }
}
