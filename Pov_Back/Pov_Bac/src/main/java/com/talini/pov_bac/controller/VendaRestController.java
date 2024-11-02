package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Venda;
import com.talini.pov_bac.service.VendaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping(path = "/api/venda")
public class VendaRestController {
    private final VendaService vendaService;

    public VendaRestController(VendaService vendaService) {
        this.vendaService = vendaService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<Venda>> getAll(){return ResponseEntity.ok(vendaService.getAllVendas());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<Venda> getById(@PathVariable("id") int id){ return ResponseEntity.ok(vendaService.getVendaByID(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        vendaService.delete(id);
        return ResponseEntity.ok("Venda deletada");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody Venda venda)
    {
        vendaService.save(venda);
        return ResponseEntity.ok("Venda salva com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Venda venda, @RequestParam int id){
        Venda vfinal = vendaService.getVendaByID(id);
        if(venda == null){
            return ResponseEntity.badRequest().build();
        }else if(venda.getId() == vfinal.getId()){
            if(!venda.getFormaPagamento().isBlank() && !venda.getFormaPagamento().isEmpty()){
                vfinal.setFormaPagamento(venda.getFormaPagamento());
            }
            if(venda.getIdPedido() != 0){
                vfinal.setIdPedido(venda.getIdPedido());
            }
            if(venda.getValorPedido() > 0){
                vfinal.setValorPedido(venda.getValorPedido());
            }
            if(venda.getCreditoDisponivel() > 0){
                vfinal.setCreditoDisponivel(venda.getCreditoDisponivel());
            }
            vendaService.save(vfinal);
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Venda atualizada");
    }
}
