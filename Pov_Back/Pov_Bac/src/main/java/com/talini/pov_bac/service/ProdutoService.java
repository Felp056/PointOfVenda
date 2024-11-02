package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.ProdutoRepostitory;
import com.talini.pov_bac.model.Produto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProdutoService {
    ProdutoRepostitory produtoRepostitory;
    public ProdutoService(ProdutoRepostitory produtoRepostitory) {this.produtoRepostitory = produtoRepostitory;}

    public Produto getProdutoById(int id) {return produtoRepostitory.findProdutoByIdProduto(id);}
    public List<Produto> getAllProduto(){return produtoRepostitory.findAll();}
    public void delete(int id){produtoRepostitory.deleteById(id);}
    public void save(Produto produto) {produtoRepostitory.save(produto);}
}
