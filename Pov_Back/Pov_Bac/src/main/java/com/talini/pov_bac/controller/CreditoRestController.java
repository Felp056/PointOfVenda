package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Credito;
import com.talini.pov_bac.service.CreditoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/credito")
public class CreditoRestController {
    private final CreditoService creditoService;

    public CreditoRestController(CreditoService creditoService) {
        this.creditoService = creditoService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<Credito>> getAll(){return ResponseEntity.ok(creditoService.getAllCreditos());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<Credito> getById(@PathVariable("id") int id){ return ResponseEntity.ok(creditoService.getCreditoById(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        creditoService.delete(id);
        return ResponseEntity.ok("Credito deletado");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody Credito credito)
    {
        creditoService.save(credito);
        return ResponseEntity.ok("Credito salvo com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Credito credito, @RequestParam int id){
        Credito cred = creditoService.getCreditoById(id);
        if(credito == null){
            return ResponseEntity.badRequest().build();
        }else if(cred.getDocumento() == credito.getDocumento()){
            cred.setCreditoConsumido(credito.getCreditoConsumido());
            if(credito.getNome() != null){
                cred.setNome(credito.getNome());
            }
            if(credito.getTotCredito() > 0){
                cred.setTotCredito(credito.getTotCredito());
            }
            creditoService.save(cred);
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("credito atualizado");
    }
}
