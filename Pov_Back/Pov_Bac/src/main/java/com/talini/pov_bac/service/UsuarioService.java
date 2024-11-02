package com.talini.pov_bac.service;

import com.talini.pov_bac.Repository.UsuarioRepository;
import com.talini.pov_bac.model.Usuario;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {
    UsuarioRepository usuarioRepository;
    public UsuarioService(UsuarioRepository usuarioRepository) {this.usuarioRepository = usuarioRepository;}

    public Usuario getUsuarioByID(int id){return usuarioRepository.findUsuarioById(id);}
    public List<Usuario> getAllUsuarios(){return usuarioRepository.findAll();}
    public void delete(int id) {usuarioRepository.deleteById(id);}
    public void save(Usuario usuario) {usuarioRepository.save(usuario);}
}
