package com.talini.pov_bac.controller;

import com.talini.pov_bac.model.Usuario;
import com.talini.pov_bac.service.UsuarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/api/usuario")
public class UsuarioResController {
    private final UsuarioService usuarioService;

    public UsuarioResController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping(path = "/todas")
    public ResponseEntity<List<Usuario>> getAll(){return ResponseEntity.ok(usuarioService.getAllUsuarios());}

    @PostMapping(path = "/{id}")
    public ResponseEntity<Usuario> getById(@PathVariable("id") int id){ return ResponseEntity.ok(usuarioService.getUsuarioByID(id));}

    @PostMapping(path = "/login")
    public ResponseEntity<Boolean> login(@RequestParam String Email, @RequestParam String Senha){
        List<Usuario> list = usuarioService.getAllUsuarios();
        for (Usuario usuario : list) {
            if(usuario.getEmail().equals(Email) && usuario.getSenha().equals(Senha)){
                return ResponseEntity.ok(true);
            }
        }
        return ResponseEntity.ok(false);
    }

    @DeleteMapping(path = "/delete")
    public ResponseEntity delete(@RequestParam int id)
    {
        usuarioService.delete(id);
        return ResponseEntity.ok("Usuario deletado");
    }

    @PostMapping(path = "/adicionar")
    public ResponseEntity add(@RequestBody Usuario Usuario)
    {
        usuarioService.save(Usuario);
        return ResponseEntity.ok("Usuario salvo com sucesso");
    }

    @PostMapping(path = "/atualizar")
    public ResponseEntity atualizar(@RequestBody Usuario usuario){
        Usuario user = usuarioService.getUsuarioByID(usuario.getId());
        if(user.getId()  == usuario.getId()){
            if(!usuario.getEmail().isEmpty() && !usuario.getEmail().isBlank()){
                user.setEmail(usuario.getEmail());
            }
            if(!usuario.getSenha().isEmpty() && !usuario.getSenha().isBlank()){
                user.setSenha(usuario.getSenha());
            }
            user.setNivelAcesso(usuario.getNivelAcesso());
            usuarioService.save(user);
        }else {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok("Usuario atualizado");
    }
}
