package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.ContasAReceber;
import com.talini.pov_bac.service.ContasAReceberService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/contasareceber")
public class ContasAReceberResController {
    private final ContasAReceberService contasAReceberService;

    public ContasAReceberResController(ContasAReceberService contasAReceberService) {
        this.contasAReceberService = contasAReceberService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<ContasAReceber>> getAll(){return ResponseEntity.ok(contasAReceberService.getAllContasAReceber());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<ContasAReceber> getById(@PathVariable("id") int id){ return ResponseEntity.ok(contasAReceberService.getContasAReceberById(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        contasAReceberService.delete(id);
        return ResponseEntity.ok("Conta a receber deletada");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody ContasAReceber contasAReceber)
    {
        contasAReceberService.save(contasAReceber);
        return ResponseEntity.ok("Salva com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody ContasAReceber contasAReceber, @RequestParam int id){
        ContasAReceber cont = contasAReceberService.getContasAReceberById(id);
        if(cont.getDocumento() == contasAReceber.getDocumento()){
            cont.setParcelas(contasAReceber.getParcelas());
            if(contasAReceber.getIdVenda() != null){
                cont.setIdVenda(contasAReceber.getIdVenda());
            }
            if(contasAReceber.getValorTotal() > 0){
                cont.setValorTotal(contasAReceber.getValorTotal());
            }
            contasAReceberService.save(cont);
        }else if(contasAReceber == null){
            return ResponseEntity.badRequest().build();
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Conta a receber atualizada");
    }
}
