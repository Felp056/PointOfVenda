package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Preco;
import com.talini.pov_bac.model.Produto;
import com.talini.pov_bac.service.PrecoService;
import com.talini.pov_bac.service.ProdutoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/preco")
public class PrecoRestController {
    private final PrecoService precoService;
    private final ProdutoService produtoService;

    public PrecoRestController(PrecoService precoService, ProdutoService produtoService) {
        this.precoService = precoService;
        this.produtoService = produtoService;
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
        if (validateProduto(preco)) {
            precoService.save(preco);
            return ResponseEntity.ok("Preco salvo com sucesso");
        }else {
            return ResponseEntity.badRequest().build();
        }

    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Preco preco, @RequestParam int id){
        Preco pre = precoService.getPrecoById(id);
        if(validateProduto(preco)) {
            if (preco == null) {
                return ResponseEntity.badRequest().build();
            } else if (pre.getCodTabela() == preco.getCodTabela()) {
                pre.setPromocao(preco.isPromocao());
                if (preco.getProdutos() != null) {
                    pre.setProdutos(preco.getProdutos());
                }
                if (!preco.getNomeTabela().isEmpty() && !preco.getNomeTabela().isEmpty()) {
                    pre.setNomeTabela(preco.getNomeTabela());
                }
                if (preco.getCodTabela() >= 0) {
                    pre.setCodTabela(preco.getCodTabela());
                }
                precoService.save(pre);
            } else {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok("Preco atualizado");
        }else{
            return ResponseEntity.badRequest().build();//ResponseEntity.ok("Produtos na tabela de preço não encontrados");
        }
    }

    public boolean validateProduto(Preco preco){
        if(preco.getProdutos() != null) {
            List<Produto> listProd = produtoService.getAllProduto();
            for (Produto prod : preco.getProdutos()) {
                if (!(listProd.get(listProd.indexOf(prod)).getIdProduto() == prod.getIdProduto())) {
                    return false;
                }
            }
        }
        return true;
    }
}
