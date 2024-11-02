package com.talini.pov_bac.Repository;

import com.talini.pov_bac.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Usuario findUsuarioById(int id);
}
