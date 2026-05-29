package com.example.demo.controllers;

import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.RegistreRequest;
import com.example.demo.dto.usuario.*;
import com.example.demo.services.UsuarioService;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuarios")
@Tag(name = "Usuarios", description = "Operaciones de usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping
    public List<UsuarioDTO> getUsuarios() {
        return usuarioService.findAll();
    }

    @GetMapping("/listado")
    public List<UsuarioListadoDTO> getUsuariosListado() {
        return usuarioService.finAllListado();
    }

    @GetMapping("/{id}")
    public UsuarioDetalleDTO getUsuario(@PathVariable Long id) {
        return usuarioService.findById(id);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public UsuarioDTO createUsuario(@RequestBody UsuarioCreateDTO usuario) {
        return usuarioService.save(usuario);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/{id}/rol")
    public void updateRolUsuario(@PathVariable Long id) {
        usuarioService.updateRol(id);
    }

    @PutMapping("/{id}")
    public UsuarioDTO updateUsuario(@PathVariable Long id, @RequestBody UsuarioUpdateDTO usuario) {
        return usuarioService.update(id, usuario);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("{id}")
    public void deleteUsuario(@PathVariable Long id) {
        usuarioService.delete(id);
    }
}
