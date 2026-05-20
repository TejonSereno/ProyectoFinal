package com.example.demo.controllers;

import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.RegistreRequest;
import com.example.demo.dto.usuario.*;
import com.example.demo.services.UsuarioService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
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

    @PostMapping("/login")
    public UsuarioDetalleDTO logUsuario(@RequestBody LoginRequest loginRequest){
        return usuarioService.login(loginRequest);
    }

    @PostMapping("/create")
    public UsuarioDTO createUsuario(@RequestBody UsuarioCreateDTO usuario) {
        return usuarioService.save(usuario);
    }

    @PostMapping("/registre")
    public UsuarioDetalleDTO registreUsuario(@RequestBody RegistreRequest registreRequest){
        return usuarioService.registre(registreRequest);
    }

    @PostMapping("/{id}/rol")
    public void updateRolUsuario(@PathVariable Long id) {
        usuarioService.updateRol(id);
    }

    @PutMapping("/{id}")
    public UsuarioDTO updateUsuario(@PathVariable Long id, @RequestBody UsuarioUpdateDTO usuario) {
        return usuarioService.update(id, usuario);
    }

    @DeleteMapping("/{id}")
    public void deleteUsuario(@PathVariable Long id) {
        usuarioService.delete(id);
    }
}
