package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Produto;
import com.talini.pov_bac.service.ProdutoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/produto")
public class ProdutoRestController {
    private final ProdutoService produtoService;

    public ProdutoRestController(ProdutoService produtoService) {
        this.produtoService = produtoService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<Produto>> getAll(){return ResponseEntity.ok(produtoService.getAllProduto());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<Produto> getById(@PathVariable("id") int id){ return ResponseEntity.ok(produtoService.getProdutoById(id));}

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        produtoService.delete(id);
        return ResponseEntity.ok("Produto deletado");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody Produto produto)
    {
        produtoService.save(produto);
        return ResponseEntity.ok("Produto salvo com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Produto produto, @RequestParam int id){
        Produto prod = produtoService.getProdutoById(id);
        if(produto == null){
            return ResponseEntity.badRequest().build();
        }else if(prod.getIdProduto() == produto.getIdProduto()){
            if(!produto.getDescricao().isBlank() || !produto.getDescricao().isBlank()) {
                prod.setDescricao(produto.getDescricao());
            }
            if(!produto.getMedida().isBlank() || !produto.getMedida().isBlank()) {
                prod.setMedida(produto.getMedida());
            }
            if(produto.getCodBarras() != 0){
                prod.setCodBarras(produto.getCodBarras());
            }
            if(produto.getQtdDisponivel() > 0){
                prod.setQtdDisponivel(produto.getQtdDisponivel());
            }
            produtoService.save(prod);
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Produto atualizado");
    }
}
