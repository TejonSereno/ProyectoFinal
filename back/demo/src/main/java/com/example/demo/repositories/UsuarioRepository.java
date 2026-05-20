package com.example.demo.repositories;

import com.example.demo.dto.usuario.UsuarioListadoDTO;
import com.example.demo.models.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    @Query("""
        SELECT new com.example.demo.dto.usuario.UsuarioListadoDTO(
            u.id, u.nombre, u.email, u.rol, v.calle, v.numero
        )
        FROM Usuario u
        LEFT JOIN u.vivienda v
        GROUP BY u.id, u.nombre, u.email, u.rol, v.calle, v.numero
    """)
    List<UsuarioListadoDTO> findAllListado();
    Optional<Usuario> findByEmail(String email);
    Boolean existsByEmail(String email);
}
