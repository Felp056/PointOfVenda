package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Preco;
import com.talini.pov_bac.service.PrecoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/preco")
public class PrecoRestController {
    private final PrecoService precoService;

    public PrecoRestController(PrecoService precoService) {
        this.precoService = precoService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<Preco>> getAll(){return ResponseEntity.ok(precoService.getAllPrecos());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<Preco> getById(@PathVariable("id") int id){ return ResponseEntity.ok(precoService.getPrecoById(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        precoService.delete(id);
        return ResponseEntity.ok("Preco deletado");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody Preco preco)
    {
        precoService.save(preco);
        return ResponseEntity.ok("Preco salvo com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Preco preco, @RequestParam int id){
        Preco pre = precoService.getPrecoById(id);
        if(preco == null){
            return ResponseEntity.badRequest().build();
        }else if(pre.getCodTabela() == preco.getCodTabela()){
            pre.setPromocao(preco.isPromocao());
            if(preco.getProdutos() != null){
                pre.setProdutos(preco.getProdutos());
            }
            if(!preco.getNomeTabela().isEmpty() && !preco.getNomeTabela().isEmpty()) {
                pre.setNomeTabela(preco.getNomeTabela());
            }
            if(preco.getCodTabela() >= 0){
                pre.setCodTabela(preco.getCodTabela());
            }
            precoService.save(pre);
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Preco atualizado");
    }
}
